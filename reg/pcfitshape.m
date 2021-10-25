function [model, stat] = pcfitshape(pcl)
%% fit shape to data

ptCloudIn = pointCloud(pcl);
diam = max(pcl) - min(pcl);

%%
figure(150); clf; hold on; axis equal; grid on;

pcshow(ptCloudIn,'MarkerSize',20);
%%
if 0
  %% sphere
  [model, ptin, ptout, merr] = pcfitsphere(ptCloudIn,max(diam)/2);
  stat.MeanError = merr;
  stat.InlierRatio = length(ptin)/size(pcl,1);
  %
  hm = model.plot;
  title(sprintf('sphere R=%.2f MSE=%.2f',model.Radius,stat.MeanError));
else
  %%
  indices = 1:size(pcl,1); %randperm(size(pcl,1), round(size(pcl,1)/2));
  [model.Center, model.Radius, model.Orientation, model.Algebraic, chi2, udist ] = pcfitellipsoid(pcl, '0',indices);
  indices = udist<0.5;
  [model.Center, model.Radius, model.Orientation, model.Algebraic, chi2, udist ] = pcfitellipsoid(pcl, '0' ,indices);
  
  model.Params = [model.Center' model.Radius' rad2deg(rotm2eul(model.Orientation))];
  
  stat.MeanError = sqrt(chi2);
  stat.InlierRatio = 1;
  
  hm = drawEllipsoid(model.Params);
  hm.LineStyle = '-';
  title(sprintf('ellipsoid R=[%.2f, %.2f, %.2f] MSE=%.2f',model.Radius(1),model.Radius(2),model.Radius(3),stat.MeanError));
end
%%
hm.FaceAlpha = 0.2;
hm.EdgeAlpha = 0.2;
pause(1);