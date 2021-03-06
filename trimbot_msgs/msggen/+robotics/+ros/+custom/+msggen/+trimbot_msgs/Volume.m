classdef Volume < robotics.ros.Message
  %Volume MATLAB implementation of trimbot_msgs/Volume
  %   This class was automatically generated by
  %   robotics.ros.msg.internal.gen.MessageClassGenerator.
  
  %   Copyright 2014-2019 The MathWorks, Inc.
  
  %#ok<*INUSD>
  
  properties (Constant)
    MessageType = 'trimbot_msgs/Volume' % The ROS message type
  end
  
  properties (Constant, Hidden)
    MD5Checksum = '416ec2a679123b340349bb9902c9fe4a' % The MD5 Checksum of the message definition
  end
  
  properties (Access = protected)
    JavaMessage % The Java message object
  end
  
  properties (Constant, Access = protected)
    GeometryMsgsPoint32Class = robotics.ros.msg.internal.MessageFactory.getClassForType('geometry_msgs/Point32') % Dispatch to MATLAB class for message type geometry_msgs/Point32
    GeometryMsgsVector3Class = robotics.ros.msg.internal.MessageFactory.getClassForType('geometry_msgs/Vector3') % Dispatch to MATLAB class for message type geometry_msgs/Vector3
    StdMsgsHeaderClass = robotics.ros.msg.internal.MessageFactory.getClassForType('std_msgs/Header') % Dispatch to MATLAB class for message type std_msgs/Header
  end
  
  properties (Dependent)
    Header
    Id
    Count
    Scale
    Pos
    Pcov
    Norm
    Ncov
    Color
    Ccov
    Occ
    Dist
    Proto
  end
  
  properties (Access = protected)
    Cache = struct('Header', [], 'Pos', [], 'Norm', [], 'Color', []) % The cache for fast data access
  end
  
  properties (Constant, Hidden)
    PropertyList = {'Ccov', 'Color', 'Count', 'Dist', 'Header', 'Id', 'Ncov', 'Norm', 'Occ', 'Pcov', 'Pos', 'Proto', 'Scale'} % List of non-constant message properties
    ROSPropertyList = {'ccov', 'color', 'count', 'dist', 'header', 'id', 'ncov', 'norm', 'occ', 'pcov', 'pos', 'proto', 'scale'} % List of non-constant ROS message properties
  end
  
  methods
    function obj = Volume(msg)
      %Volume Construct the message object Volume
      import com.mathworks.toolbox.robotics.ros.message.MessageInfo;
      
      % Support default constructor
      if nargin == 0
        obj.JavaMessage = obj.createNewJavaMessage;
        return;
      end
      
      % Construct appropriate empty array
      if isempty(msg)
        obj = obj.empty(0,1);
        return;
      end
      
      % Make scalar construction fast
      if isscalar(msg)
        % Check for correct input class
        if ~MessageInfo.compareTypes(msg(1), obj.MessageType)
          error(message('robotics:ros:message:NoTypeMatch', obj.MessageType, ...
            char(MessageInfo.getType(msg(1))) ));
        end
        obj.JavaMessage = msg(1);
        return;
      end
      
      % Check that this is a vector of scalar messages. Since this
      % is an object array, use arrayfun to verify.
      if ~all(arrayfun(@isscalar, msg))
        error(message('robotics:ros:message:MessageArraySizeError'));
      end
      
      % Check that all messages in the array have the correct type
      if ~all(arrayfun(@(x) MessageInfo.compareTypes(x, obj.MessageType), msg))
        error(message('robotics:ros:message:NoTypeMatchArray', obj.MessageType));
      end
      
      % Construct array of objects if necessary
      objType = class(obj);
      for i = 1:length(msg)
        obj(i,1) = feval(objType, msg(i)); %#ok<AGROW>
      end
    end
    
    function header = get.Header(obj)
      %get.Header Get the value for property Header
      if isempty(obj.Cache.Header)
        obj.Cache.Header = feval(obj.StdMsgsHeaderClass, obj.JavaMessage.getHeader);
      end
      header = obj.Cache.Header;
    end
    
    function set.Header(obj, header)
      %set.Header Set the value for property Header
      validateattributes(header, {obj.StdMsgsHeaderClass}, {'nonempty', 'scalar'}, 'Volume', 'Header');
      
      obj.JavaMessage.setHeader(header.getJavaObject);
      
      % Update cache if necessary
      if ~isempty(obj.Cache.Header)
        obj.Cache.Header.setJavaObject(header.getJavaObject);
      end
    end
    
    function id = get.Id(obj)
      %get.Id Get the value for property Id
      id = typecast(int32(obj.JavaMessage.getId), 'uint32');
    end
    
    function set.Id(obj, id)
      %set.Id Set the value for property Id
      validateattributes(id, {'numeric'}, {'nonempty', 'scalar'}, 'Volume', 'Id');
      
      obj.JavaMessage.setId(id);
    end
    
    function count = get.Count(obj)
      %get.Count Get the value for property Count
      count = typecast(int32(obj.JavaMessage.getCount), 'uint32');
    end
    
    function set.Count(obj, count)
      %set.Count Set the value for property Count
      validateattributes(count, {'numeric'}, {'nonempty', 'scalar'}, 'Volume', 'Count');
      
      obj.JavaMessage.setCount(count);
    end
    
    function scale = get.Scale(obj)
      %get.Scale Get the value for property Scale
      javaArray = obj.JavaMessage.getScale;
      array = obj.readJavaArray(javaArray, 'single');
      scale = single(array);
    end
    
    function set.Scale(obj, scale)
      %set.Scale Set the value for property Scale
      if ~isvector(scale) && isempty(scale)
        % Allow empty [] input
        scale = single.empty(0,1);
      end
      
      validateattributes(scale, {'numeric'}, {'vector'}, 'Volume', 'Scale');
      
      javaArray = obj.JavaMessage.getScale;
      array = obj.writeJavaArray(scale, javaArray, 'single');
      obj.JavaMessage.setScale(array);
    end
    
    function pos = get.Pos(obj)
      %get.Pos Get the value for property Pos
      if isempty(obj.Cache.Pos)
        javaArray = obj.JavaMessage.getPos;
        array = obj.readJavaArray(javaArray, obj.GeometryMsgsPoint32Class);
        obj.Cache.Pos = feval(obj.GeometryMsgsPoint32Class, array);
      end
      pos = obj.Cache.Pos;
    end
    
    function set.Pos(obj, pos)
      %set.Pos Set the value for property Pos
      if ~isvector(pos) && isempty(pos)
        % Allow empty [] input
        pos = feval([obj.GeometryMsgsPoint32Class '.empty'], 0, 1);
      end
      
      validateattributes(pos, {obj.GeometryMsgsPoint32Class}, {'vector'}, 'Volume', 'Pos');
      
      javaArray = obj.JavaMessage.getPos;
      array = obj.writeJavaArray(pos, javaArray, obj.GeometryMsgsPoint32Class);
      obj.JavaMessage.setPos(array);
      
      % Update cache if necessary
      if ~isempty(obj.Cache.Pos)
        obj.Cache.Pos = [];
        obj.Cache.Pos = obj.Pos;
      end
    end
    
    function pcov = get.Pcov(obj)
      %get.Pcov Get the value for property Pcov
      javaArray = obj.JavaMessage.getPcov;
      array = obj.readJavaArray(javaArray, 'single');
      pcov = single(array);
    end
    
    function set.Pcov(obj, pcov)
      %set.Pcov Set the value for property Pcov
      if ~isvector(pcov) && isempty(pcov)
        % Allow empty [] input
        pcov = single.empty(0,1);
      end
      
      validateattributes(pcov, {'numeric'}, {'vector'}, 'Volume', 'Pcov');
      
      javaArray = obj.JavaMessage.getPcov;
      array = obj.writeJavaArray(pcov, javaArray, 'single');
      obj.JavaMessage.setPcov(array);
    end
    
    function norm = get.Norm(obj)
      %get.Norm Get the value for property Norm
      if isempty(obj.Cache.Norm)
        javaArray = obj.JavaMessage.getNorm;
        array = obj.readJavaArray(javaArray, obj.GeometryMsgsVector3Class);
        obj.Cache.Norm = feval(obj.GeometryMsgsVector3Class, array);
      end
      norm = obj.Cache.Norm;
    end
    
    function set.Norm(obj, norm)
      %set.Norm Set the value for property Norm
      if ~isvector(norm) && isempty(norm)
        % Allow empty [] input
        norm = feval([obj.GeometryMsgsVector3Class '.empty'], 0, 1);
      end
      
      validateattributes(norm, {obj.GeometryMsgsVector3Class}, {'vector'}, 'Volume', 'Norm');
      
      javaArray = obj.JavaMessage.getNorm;
      array = obj.writeJavaArray(norm, javaArray, obj.GeometryMsgsVector3Class);
      obj.JavaMessage.setNorm(array);
      
      % Update cache if necessary
      if ~isempty(obj.Cache.Norm)
        obj.Cache.Norm = [];
        obj.Cache.Norm = obj.Norm;
      end
    end
    
    function ncov = get.Ncov(obj)
      %get.Ncov Get the value for property Ncov
      javaArray = obj.JavaMessage.getNcov;
      array = obj.readJavaArray(javaArray, 'single');
      ncov = single(array);
    end
    
    function set.Ncov(obj, ncov)
      %set.Ncov Set the value for property Ncov
      if ~isvector(ncov) && isempty(ncov)
        % Allow empty [] input
        ncov = single.empty(0,1);
      end
      
      validateattributes(ncov, {'numeric'}, {'vector'}, 'Volume', 'Ncov');
      
      javaArray = obj.JavaMessage.getNcov;
      array = obj.writeJavaArray(ncov, javaArray, 'single');
      obj.JavaMessage.setNcov(array);
    end
    
    function color = get.Color(obj)
      %get.Color Get the value for property Color
      if isempty(obj.Cache.Color)
        javaArray = obj.JavaMessage.getColor;
        array = obj.readJavaArray(javaArray, obj.GeometryMsgsVector3Class);
        obj.Cache.Color = feval(obj.GeometryMsgsVector3Class, array);
      end
      color = obj.Cache.Color;
    end
    
    function set.Color(obj, color)
      %set.Color Set the value for property Color
      if ~isvector(color) && isempty(color)
        % Allow empty [] input
        color = feval([obj.GeometryMsgsVector3Class '.empty'], 0, 1);
      end
      
      validateattributes(color, {obj.GeometryMsgsVector3Class}, {'vector'}, 'Volume', 'Color');
      
      javaArray = obj.JavaMessage.getColor;
      array = obj.writeJavaArray(color, javaArray, obj.GeometryMsgsVector3Class);
      obj.JavaMessage.setColor(array);
      
      % Update cache if necessary
      if ~isempty(obj.Cache.Color)
        obj.Cache.Color = [];
        obj.Cache.Color = obj.Color;
      end
    end
    
    function ccov = get.Ccov(obj)
      %get.Ccov Get the value for property Ccov
      javaArray = obj.JavaMessage.getCcov;
      array = obj.readJavaArray(javaArray, 'single');
      ccov = single(array);
    end
    
    function set.Ccov(obj, ccov)
      %set.Ccov Set the value for property Ccov
      if ~isvector(ccov) && isempty(ccov)
        % Allow empty [] input
        ccov = single.empty(0,1);
      end
      
      validateattributes(ccov, {'numeric'}, {'vector'}, 'Volume', 'Ccov');
      
      javaArray = obj.JavaMessage.getCcov;
      array = obj.writeJavaArray(ccov, javaArray, 'single');
      obj.JavaMessage.setCcov(array);
    end
    
    function occ = get.Occ(obj)
      %get.Occ Get the value for property Occ
      javaArray = obj.JavaMessage.getOcc;
      array = obj.readJavaArray(javaArray, 'single');
      occ = single(array);
    end
    
    function set.Occ(obj, occ)
      %set.Occ Set the value for property Occ
      if ~isvector(occ) && isempty(occ)
        % Allow empty [] input
        occ = single.empty(0,1);
      end
      
      validateattributes(occ, {'numeric'}, {'vector'}, 'Volume', 'Occ');
      
      javaArray = obj.JavaMessage.getOcc;
      array = obj.writeJavaArray(occ, javaArray, 'single');
      obj.JavaMessage.setOcc(array);
    end
    
    function dist = get.Dist(obj)
      %get.Dist Get the value for property Dist
      javaArray = obj.JavaMessage.getDist;
      array = obj.readJavaArray(javaArray, 'single');
      dist = single(array);
    end
    
    function set.Dist(obj, dist)
      %set.Dist Set the value for property Dist
      if ~isvector(dist) && isempty(dist)
        % Allow empty [] input
        dist = single.empty(0,1);
      end
      
      validateattributes(dist, {'numeric'}, {'vector'}, 'Volume', 'Dist');
      
      javaArray = obj.JavaMessage.getDist;
      array = obj.writeJavaArray(dist, javaArray, 'single');
      obj.JavaMessage.setDist(array);
    end
    
    function proto = get.Proto(obj)
      %get.Proto Get the value for property Proto
      javaArray = obj.JavaMessage.getProto;
      array = obj.readJavaArray(javaArray, 'uint32');
      proto = uint32(array);
    end
    
    function set.Proto(obj, proto)
      %set.Proto Set the value for property Proto
      if ~isvector(proto) && isempty(proto)
        % Allow empty [] input
        proto = uint32.empty(0,1);
      end
      
      validateattributes(proto, {'numeric'}, {'vector'}, 'Volume', 'Proto');
      
      javaArray = obj.JavaMessage.getProto;
      array = obj.writeJavaArray(proto, javaArray, 'uint32');
      obj.JavaMessage.setProto(array);
    end
  end
  
  methods (Access = protected)
    function resetCache(obj)
      %resetCache Resets any cached properties
      obj.Cache.Header = [];
      obj.Cache.Pos = [];
      obj.Cache.Norm = [];
      obj.Cache.Color = [];
    end
    
    function cpObj = copyElement(obj)
      %copyElement Implements deep copy behavior for message
      
      % Call default copy method for shallow copy
      cpObj = copyElement@robotics.ros.Message(obj);
      
      % Clear any existing cached properties
      cpObj.resetCache;
      
      % Create a new Java message object
      cpObj.JavaMessage = obj.createNewJavaMessage;
      
      % Iterate over all primitive properties
      cpObj.Id = obj.Id;
      cpObj.Count = obj.Count;
      cpObj.Scale = obj.Scale;
      cpObj.Pcov = obj.Pcov;
      cpObj.Ncov = obj.Ncov;
      cpObj.Ccov = obj.Ccov;
      cpObj.Occ = obj.Occ;
      cpObj.Dist = obj.Dist;
      cpObj.Proto = obj.Proto;
      
      % Recursively copy compound properties
      cpObj.Header = copy(obj.Header);
      cpObj.Pos = copy(obj.Pos);
      cpObj.Norm = copy(obj.Norm);
      cpObj.Color = copy(obj.Color);
    end
    
    function reload(obj, strObj)
      %reload Called by loadobj to assign properties
      obj.Id = strObj.Id;
      obj.Count = strObj.Count;
      obj.Scale = strObj.Scale;
      obj.Pcov = strObj.Pcov;
      obj.Ncov = strObj.Ncov;
      obj.Ccov = strObj.Ccov;
      obj.Occ = strObj.Occ;
      obj.Dist = strObj.Dist;
      obj.Proto = strObj.Proto;
      obj.Header = feval([obj.StdMsgsHeaderClass '.loadobj'], strObj.Header);
      PosCell = arrayfun(@(x) feval([obj.GeometryMsgsPoint32Class '.loadobj'], x), strObj.Pos, 'UniformOutput', false);
      obj.Pos = vertcat(PosCell{:});
      NormCell = arrayfun(@(x) feval([obj.GeometryMsgsVector3Class '.loadobj'], x), strObj.Norm, 'UniformOutput', false);
      obj.Norm = vertcat(NormCell{:});
      ColorCell = arrayfun(@(x) feval([obj.GeometryMsgsVector3Class '.loadobj'], x), strObj.Color, 'UniformOutput', false);
      obj.Color = vertcat(ColorCell{:});
    end
  end
  
  methods (Access = ?robotics.ros.Message)
    function strObj = saveobj(obj)
      %saveobj Implements saving of message to MAT file
      
      % Return an empty element if object array is empty
      if isempty(obj)
        strObj = struct.empty;
        return
      end
      
      strObj.Id = obj.Id;
      strObj.Count = obj.Count;
      strObj.Scale = obj.Scale;
      strObj.Pcov = obj.Pcov;
      strObj.Ncov = obj.Ncov;
      strObj.Ccov = obj.Ccov;
      strObj.Occ = obj.Occ;
      strObj.Dist = obj.Dist;
      strObj.Proto = obj.Proto;
      strObj.Header = saveobj(obj.Header);
      strObj.Pos = arrayfun(@(x) saveobj(x), obj.Pos);
      strObj.Norm = arrayfun(@(x) saveobj(x), obj.Norm);
      strObj.Color = arrayfun(@(x) saveobj(x), obj.Color);
    end
  end
  
  methods (Static, Access = {?matlab.unittest.TestCase, ?robotics.ros.Message})
    function obj = loadobj(strObj)
      %loadobj Implements loading of message from MAT file
      
      % Return an empty object array if the structure element is not defined
      if isempty(strObj)
        obj = robotics.ros.custom.msggen.trimbot_msgs.Volume.empty(0,1);
        return
      end
      
      % Create an empty message object
      obj = robotics.ros.custom.msggen.trimbot_msgs.Volume;
      obj.reload(strObj);
    end
  end
end
