%% test matching of two sets
addpath '../../code/gurobi/matlab';

M = 20;
%N = 10;
%% generate random params
P = zeros(M,9);

P(:,1) = linspace(1,M,M); % transl
P(:,2) = 0.1*rand(M,1);
P(:,4:6) = 0.1+rand(M,3)/5; % diam
%
Zgt = 1:M;
%Zgt = randperm(M); 
%Zgt = 2:9; 
%Zgt = [1:3 5 7:9]; 

N = length(Zgt);
Q = P(Zgt,:);
Q(:,1) = Q(:,1) + 1;
Q(:,2) = Q(:,2) + linspace(2,5,N)';
Q(:,1:3) = Q(:,1:3) + normrnd(0,0.1,N,3);
Q(:,4:6) = Q(:,4:6) + (rand(N,3)-0.5)/10;

%% match
tic;
Zm = ldmatch(P,Q,0.1);
toc;
%figure(110); spy(Zm);
[Zi, Zj] = find(Zm'==1);
Zgtm = false(M,N);
for i = 1:N
  Zgtm(Zgt(i),i) = 1;
end

fprintf('Result check: %d/%d wrong matches\n',sum(Zgtm(:)~=Zm(:)),M); 

%%
figure(170); clf; hold on; grid on; 
plot(P(:,1),P(:,2),'b*'); %axis equal;
for i=1:M
  rectangle('Position',[P(i,1:2)-P(i,4:5)/2 P(i,4:5)],'EdgeColor','b');
end
plot(Q(:,1),Q(:,2),'r*');
for i=1:N
  rectangle('Position',[Q(i,1:2)-Q(i,4:5)/2 Q(i,4:5)],'EdgeColor','r');
end

line([P(Zgt,1) Q(:,1)]',[P(Zgt,2) Q(:,2)]','Color','g','LineWidth',3);

line([P(Zj,1) Q(Zi,1)]',[P(Zj,2) Q(Zi,2)]','Color','k');

legend('X','M','Z_{gt}'); xlabel 'x location [m]'; ylabel 'y location [m]';
