function [Ttrans,Trot] = tx2tq(T)
%TX2TQ Summary of this function goes here
%   Detailed explanation goes here

Ttrans = T(4,1:3);

Trot = rotm2quat(T(1:3,1:3)'); %  [w x y z]

fprintf('rosrun tf static_transform_publisher %f %f %f  %f %f %f %f map totalstation 100', ...
  Ttrans(1), Ttrans(2), Ttrans(3), Trot(2), Trot(3), Trot(4), Trot(1));  % tx ty tz  qx qy qz qw 

end

