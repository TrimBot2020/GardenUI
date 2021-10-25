function rosMsgOut = pcl2msg(XYZ, RGB)
%% create ros msg for color point cloud
rosMsgOut = rosmessage('sensor_msgs/PointCloud2');

% Calculate number of points
numPts = size(XYZ,1);

% Assign metadata
rosMsgOut.Height = uint32(1);
rosMsgOut.Width = uint32(numPts);
rosMsgOut.PointStep = uint32(16);
rosMsgOut.RowStep = uint32(16);

% Assign point field data
fieldNames = {'x','y','z','rgba'};
fieldTypes = [7,7,7,6];
rosMsgOut.Data = zeros(numPts*rosMsgOut.RowStep,1,'uint8');
for idx = 1:4
  rosMsgOut.Fields(idx) = rosmessage('sensor_msgs/PointField');
  fName = fieldNames{idx};
  rosMsgOut.Fields(idx).Name(1:numel(fName)) = uint8(fName);
  rosMsgOut.Fields(idx).Offset = uint32((idx-1)*4);
  rosMsgOut.Fields(idx).Datatype = uint8(fieldTypes(idx));
  rosMsgOut.Fields(idx).Count = uint32(1);
end

% Assign raw point cloud data in uint8 format
for idx = 1:numPts
  startIdx = (idx-1)*rosMsgOut.RowStep + 1;
  rosMsgOut.Data(startIdx:startIdx+11) = ...
    typecast(single(XYZ(idx,:)),'uint8');
  rosMsgOut.Data(startIdx+12:startIdx+15) = ...
    typecast(uint8(255*[RGB(idx,[3 2 1]) 1]) ,'uint8'); % argb
end

end