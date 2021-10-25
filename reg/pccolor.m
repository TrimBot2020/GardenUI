function [ Color ] = pccolor( X )
%PCCOLOR Colors for point cloud (auto-range jet/256)
%   X ... vector of scalars for each point

zn = round(255*normalize(X))+1;
jm = uint8(255*jet(256));
Color = jm(zn,:);
end

