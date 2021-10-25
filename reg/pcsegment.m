%%------------------------------------------------------
%  Project labelled 3D point cloud to 2D images
% ------------------------------------------------------
% required: Robotic System Toolbox, Computer Vision Toolbox (Matlab Inc.)
%
% (c) Radim Tylecek, University of Edinburgh, 2017
%     rtylecek@inf.ed.ac.uk
% ------------------------------------------------------
%%

dataPath = '/home/radim/Documents/proj/TrimBot/GardenDatasetWageningen2017/sfm';

%% read point cloud
pcdPath = fullfile(dataPath, 'wur2_all_sequences_colmap_dense_crop_clean_reg.ply');

fprintf('Read %s... ', pcdPath); tic;
ptCloud = pcread(pcdPath);
fprintf('%d points. ',ptCloud.Count);
toc;

%% normals
kNN = 20; %round(log(1+ptCloud.Count));
fprintf('Normal estim %d nbs ...',kNN); tic;
ptCloud.Normal = pcnormals(ptCloud,kNN);
% point up
ptCloud.Normal(ptCloud.Normal(:,3)<0,:) = -ptCloud.Normal(ptCloud.Normal(:,3)<0,:);
toc;
%%
every = 1;
x = ptCloud.Location(1:every:end,1);
y = ptCloud.Location(1:every:end,2);
z = ptCloud.Location(1:every:end,3);
u = ptCloud.Normal(1:every:end,1);
v = ptCloud.Normal(1:every:end,2);
w = ptCloud.Normal(1:every:end,3);

gndMaxZ = -1;

na = atan2(sqrt(u.^2+v.^2),w);
pNormal = normpdf(na,0,0.7);
pElev = normpdf(z,min(z),0.7);

pGround = pNormal.*pElev;

ptCloud.Color = pccolor(pGround);
%%
figure(101); clf; 
pcshow(ptCloud,'MarkerSize',100); hold on;
title('Ground prob'); colormap jet; colorbar;
%quiver3(x,y,z,u,v,w);

%% remove ground, keep objects
obji = pGround < 0.5*max(pGround);
ptObj = pointCloud(ptCloud.Location(obji,:));
ptObj.Color = ptCloud.Color(obji,:);
fprintf('Denoising objects %d pts ...',sum(obji)); tic;
ptObj = pcdenoise(ptObj,'NumNeighbors',kNN,'Threshold',1);
toc;
%%
figure(102); clf; 
pcshow(ptObj,'MarkerSize',100); hold on;
title('Objects'); colormap jet; colorbar;
drawnow;
%% cluster object points
clusterEps = 0.3;
fprintf('Clustering eps=%.3f  ',clusterEps); tic;
[clusterObj, clusterType, clusterEps] = dbscan(ptObj.Location, round(ptCloud.Count/1000), clusterEps);
objCount = max(clusterObj);
fprintf('%d clusters. ',objCount); toc;
ptObj.Color = pccolor(clusterObj);

%% filter outliers
ok = clusterType>=0;
ptRender = pointCloud(ptObj.Location(ok,:));
ptRender.Color = ptObj.Color(ok,:);

figure(103); clf; 
pcshow(ptRender,'MarkerSize',100); hold on;
title('Object clusters'); colormap jet; colorbar;
hold on;
