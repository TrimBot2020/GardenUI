function [Z, fval, cres] = ldmatch(P,Q,deform_cost)
%LDMATCH Low Distortion Correspondence Matching
%   P to Q matching with outliers
%   params(:,1:3) ... translation
%   params(:,4:6) ... diameter
%   params(:,7:9) ... orientation (EA-deg)
%%
M = size(P,1);
N = size(Q,1);
%%  generate pairs
[p,q] = meshgrid(1:M, 1:N);
pairs = [p(:) q(:)];
Np = size(pairs,1);
fprintf('ldmatch: %d pairs for %dx%d problem\n',Np,M,N);
%% calculate match
C = zeros(Np,1);
Cm = zeros(M,N);
H = zeros(Np,Np);
for a = 1:Np
  %% pairwise term
  ai = pairs(a,1);
  aj = pairs(a,2);
  pai = P(ai,:);
  paj = Q(aj,:);
  dpa = paj-pai; 
  C(a) = norm(dpa(4:6)./pai(4:6));  % diam dif
  Cm(ai,aj) = C(a);
  dta = norm(dpa(1:2));
  ota = dpa(1)/dta;
  for b = 1:Np
    %% quad term
    bi = pairs(b,1);
    bj = pairs(b,2);
    pbi = P(bi,:);
    pbj = Q(bj,:);
    % dist
    dpb = pbi-pbj; 
    dtb = norm(dpb(1:2));
    %dtab = abs(dtb-dta)/dta;      % allow rotation
    dtab = norm(dpb(1:2)+dpa(1:2));  % translation only assumption
    % ori
    otb = dpb(1)/dtb;
    otab = abs(ota-otb);
    
    H(a,b) = dtab; %+ 2*otab;
  end
end

%%

%H(H(:)>5) = 1e6;

%%
figure(160); clf; imagesc(Cm); colormap pink; colorbar;
figure(161); clf; imagesc(H,[0 5]); colormap pink; colorbar; 
drawnow;
%% assignment constraints
A = zeros(M,Np);
b = ones(M,1);
tx = zeros(Np,1);
for i = 1:M
  imp = find(pairs(:,1)==i); 
  A(i, imp) = 1;
  tx(imp(1)) = 1;
end

%% solve with gurobi
qp = struct();
qp.Q = sparse(H)*deform_cost;
qp.obj = C;
qp.A = sparse(A);
qp.rhs = b;
qp.sense = '=';
qp.vtype = 'B';
qp.lb = zeros(Np,1);
qp.ub = ones(Np,1);

qopt = struct();

qres = gurobi(qp,qopt);
%% solution
disp(qres);
Z = reshape(qres.x,N,M)';
Z = logical(Z>0.5);
fval = qres.objval;
cres = sum(qp.A*qres.x - qp.rhs);
fprintf('ldmatch: match constraint residual %.3g\n',cres);
%%
figure(160); hold on; spy(Z,30);  xlabel('Y'); ylabel('X'); title('unary cost');
figure(161); hold on; xlabel('X \times Y pairs'); title('binary cost');
ppi = find(qres.x==1);
for i=ppi'
  for j=ppi'
    plot(i,j,'co');
    plot(i,j,'mx');
  end
end
