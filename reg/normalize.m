function [ nz ] = normalize( z )
%NORMALIZE Rescale scalars to unit range [0 1]
%   Z ... vector of scalars
zok = z(isfinite(z(:)));
if isempty(zok)
  nz = z;
  return;
end
zmin = min(zok);
zmax = max(zok);

nz = (z-zmin)/max((zmax-zmin),eps);
nz(~isfinite(z(:))) = nan;
end

