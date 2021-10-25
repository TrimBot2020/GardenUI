%% generate occupancy grid from point cloud
addpath 'yaml';

%mapdir = '/home/radim/Documents/proj/TrimBot/GardenDatasetWageningen2018/map2/';
mapdir = '/home/radim/TrimBot/GardenDatasetWageningen2019/maps/2019-09-30_11-04-25_map_tent_4/';
%mapdir = '/home/radim/Documents/proj/TrimBot/GardenDatasetBosch2019/small_garden';
%mapdir = 'maps/bosch/large_outdoor_map_sparse';
%mapdir = 'maps/bosch/closed_blinds_high_quality_aligned';
%mapdir = 'maps/bosch/outdoor_cloudy_aligned';

ply = fullfile(mapdir,'model-zup-cut.ply');
raw = fullfile(mapdir,'model-raw.ply');
cpm = 15; % preview resolution (pix/m)
%cpm = 20; % final resolution
gridres = 1/cpm;
Xrange = [-20 20];
Yrange = [-20 20];
Zrange = [-0.5 1];
%%
if ~exist(ply,'file')
  %% 1. load from colmap 5
  if ~exist(raw,'file')
    [cameras, images, points3D] = colmap_read_model(mapdir);
    pk = points3D.keys;
    nk = length(pk);
    xyz = zeros(nk,3);
    for i = 1:nk
      xyz(i,:) = points3D(pk{i}).xyz;
    end
    pcl = pointCloud(xyz);
    pcwrite(pcl,raw);
  else
    pcl = pcread(raw);
  end
  %% export sparse map pcl
  % rotate from Y-up (cam) to Z-up (world) frame
  % zup rotate phi=-90; theta=0; psi=-90
  % zup rotm = [0 0 1; -1 0 0; 0 -1 0];
  zup = rt2affine([0 0 1; -1 0 0; 0 -1 0]', [0 0 0.5]); % translate from cam height to ground
  zpcl = pctransform(pcl,zup); 
  % filter range
  inrange = zpcl.Location(:,1)>Xrange(1) & zpcl.Location(:,1)<Xrange(2) & ...
       zpcl.Location(:,2)>Yrange(1) & zpcl.Location(:,2)<Yrange(2) & ...
       zpcl.Location(:,3)>Zrange(1) & zpcl.Location(:,3)<Zrange(2);
  fpcl = pointCloud(zpcl.Location(inrange,:));
  %%
  pcl = pcdenoise(fpcl,'Threshold',0.5,'NumNeighbors',10);
  pcl = pcdenoise(pcl,'Threshold',1.0,'NumNeighbors',6);
  %pcl = pcdenoise(pcl,'Threshold',0.5,'NumNeighbors',6);
  pcwrite(pcl,ply);
  %% export cameras ply
  ik = images.keys;
  nik = length(ik);
  txyz = zeros(nik,3);
  for i = 1:nik
    txyz(i,:) = -images(ik{i}).t'*images(ik{i}).R;
  end
  tpcl = pointCloud(txyz);
  
  zpcl = pctransform(tpcl,zup);  
  pcwrite(zpcl,strrep(ply,'.ply','-cams.ply'));  
  %% 2. now edit the pcl ply in CC and cut the area of interest + filter
  % noise/outliers
  %return;
else 
  %% 3. run again load saved ply
  pcl = pcread(ply);
end
figure(22); clf; pcshow(pcl,'MarkerSize',100);
view(2); drawnow

%%
%figure(20); hist(pcl.Location(:,3),30);
%ground_z = mode(pcl.Location(:,3));

if 1
  tic;
  [bmap, pmap, hmap, gmap, grx,gry] = pcl2occ(pcl,gridres,1.5);
  toc;
  
  save(fullfile(mapdir,'occ-maps.mat'),'bmap','pmap','hmap','gmap','grx','gry','cpm','gridres');
else
  load(fullfile(mapdir,'occ-maps.mat'));
end
%% show
figure(23)
subplot(2,1,1); surf(grx, gry, 2*flip(hmap,1)); axis equal; shading interp; view(2); title('hmap');
subplot(2,1,2); surf(grx, gry, 2*flip(gmap,1)); axis equal; shading interp; view(2); title('gmap');

figure(24);
surf(grx, gry, 2*flip(pmap,1)); axis equal; shading interp; view(2); title('pmap');

figure(30); imagesc(bmap); axis image;

%% results

shmap = hmap - min(hmap(:));
imwrite(uint8(255*shmap/max(shmap(:))),jet(256),fullfile(mapdir,'height-map.png'));
sgmapf = gmap - min(gmap(:));
imwrite(uint8(255*sgmapf/max(sgmapf(:))),jet(256),fullfile(mapdir,'ground-map.png'));
sdmap = pmap - min(pmap(:));
imwrite(uint8(255*sdmap/max(sdmap(:))),jet(256),fullfile(mapdir,'occ-prob.png'));
imwrite(bmap,fullfile(mapdir,'occ-binary.png'));

%% yml
yml.image = 'occ-binary.png';
yml.resolution = gridres; 
yml.origin = [pcl.XLimits(1) pcl.YLimits(1) 0]; % x y rot
yml.negate = uint8(0);  % must be plain 0
yml.occupied_thresh = 0.2;
yml.free_thresh = 0.9;

YAML.write(fullfile(mapdir,'occupancy.yaml'),yml);

