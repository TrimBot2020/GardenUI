%% cluster pcl

addpath '../geom3d/';
addpath '../meshes3d/';
addpath '../xml_io';
addpath '../yaml';
addpath '../';
addpath '../../code/gurobi/matlab';

%% read map
figure(180); clf; hold on; axis equal; 
[hmap, map] = load_map('../maps/wur/wur31.xml');

mapCount = length(map.Objects);
mapParams = zeros(mapCount,9);
mapShapes = zeros(mapCount,1);

for i = 1:mapCount
  o = map.Objects(i);
  mapParams(i,:) = [o.pos sort(o.diam) o.orient];
  mapShapes(i) = o.shape;
end

%% read pcl
dataPath = '/home/radim/Documents/proj/TrimBot/GardenDatasetWageningen2017/sfm';

%% read point cloud
pcdPath = fullfile(dataPath, 'wur2_all_sequences_colmap_dense_crop_clean_reg.ply');

%pcsegment(
%load('clusterBig.mat');

%% fit shapes
objPoints = zeros(objCount,1);

pcdStats = zeros(objCount,3);
pcdParams = zeros(objCount,9);

for oi = 1:objCount
  %% fit to clusters
  opts = (clusterObj==oi) & (clusterType>=0);
  objX = ptObj.Location(opts,:);
  objPoints(oi) = sum(opts);
  props.diam = max(objX) - min(objX);
  props.pos = mean([max(objX); min(objX)]); % median(objX);
  props.orient = [0 0 0];
  %% 
  [model, stat] = pcfitshape(objX);
  pcdStats(oi,1) = stat.MeanError;
  pcdStats(oi,2) = stat.InlierRatio;
  pcdParams(oi,:) = model.Params;
  pcdParams(oi,4:6) = sort(abs(pcdParams(oi,4:6)));
%   objBox = drawCuboid([props.pos(1) props.pos(2) props.pos(3) props.diam props.orient]);
%   objBox.FaceColor = ptObj.Color(find(opts>=1,1),:);
%   objBox.FaceAlpha = 0.2;
end

%%  generate pairs
%P = nchoosek(1:max(mapCount,objCount),2);
[p,q] = meshgrid(1:mapCount, 1:objCount);
P = [p(:) q(:)];
% if mapCount>objCount
%   P = P(P(:,1)>P(:,2), :);
% else
%   P = P(P(:,1)<P(:,2), :);
% end
Np = size(P,1);
%% calculate match
C = zeros(Np,1);
Cm = zeros(mapCount,objCount);
H = zeros(Np,Np);
for a = 1:Np
  %% pairwise term
  ai = P(a,1);
  aj = P(a,2);
  pai = mapParams(ai,:);
  paj = pcdParams(aj,:);
  dpa = pai-paj; 
  C(a) = norm(dpa(4:6));  % diam dif
  Cm(ai,aj) = C(a);
  dta = norm(dpa(1:2));
  for b = 1:Np
    %% quad term
    bi = P(b,1);
    bj = P(b,2);
    pbi = mapParams(bi,:);
    pbj = pcdParams(bj,:);
    dpb = pbi-pbj; 
    dtb = norm(dpb(1:2));
    %dtab = dpa(1:2) - dpb(1:2);
    
    H(a,b) = abs(dtb-dta)/dta;
  end
end
%%
figure(160); imagesc(Cm,[0 5]); colormap pink; colorbar;

figure(161); imagesc(H,[0 5]); colormap pink; colorbar;

%% assignment constraints
A = zeros(mapCount,Np);
b = ones(mapCount,1);
tx = zeros(Np,1);
for i = 1:mapCount
  imp = find(P(:,1)==i); 
  A(i, imp) = 1;
  tx(imp(1)) = 1;
end
%%
if 1
  %% solve gurobi
  qp = struct();
  qp.Q = sparse(H);
  qp.obj = C;
  qp.A = sparse(A);
  qp.rhs = b;
  qp.sense = '=';
  qp.vtype = 'B';
  qp.lb = zeros(Np,1);
  qp.ub = ones(Np,1);

  qopt = struct();
  
  qres = gurobi(qp,qopt);
  
else
  %% solve matlab
  qp = struct();
  qp.H = H;
  qp.f = C;
  qp.Aeq = A;
  qp.beq = b;
  qp.lb = zeros(Np,1);
  qp.ub = ones(Np,1);
  qp.solver = 'quadprog';
  qp.options = optimoptions(qp.solver);
  qp.options.Algorithm = 'trust-region-reflective';
  qp.options.Display = 'iter';
  %qp.options.FunctionTolerance = 1e-10;
  [Z,fval,exitflag,output,lambda] = quadprog(qp);
end
%%
Zm = zeros(mapCount,objCount);
for a = 1:Np
  Zm(P(a,1),P(a,2)) = Z(a);
end

figure(162); imagesc(Zm,[0 1]); colormap pink; colorbar;