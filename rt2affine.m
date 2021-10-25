function [aff] = rt2affine(R,t)
%RT2AFFINE Summary of this function goes here
%   Detailed explanation goes here
    tx = eye(4);
    tx(1:3,1:3) = R;
    tx(4,1:3) = t;
    aff = affine3d(tx);
end
