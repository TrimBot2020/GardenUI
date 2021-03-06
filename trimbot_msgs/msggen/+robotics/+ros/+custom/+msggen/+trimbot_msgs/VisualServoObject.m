classdef VisualServoObject < robotics.ros.Message
  %VisualServoObject MATLAB implementation of trimbot_msgs/VisualServoObject
  %   This class was automatically generated by
  %   robotics.ros.msg.internal.gen.MessageClassGenerator.
  
  %   Copyright 2014-2019 The MathWorks, Inc.
  
  %#ok<*INUSD>
  
  properties (Constant)
    MessageType = 'trimbot_msgs/VisualServoObject' % The ROS message type
  end
  
  properties (Constant, Hidden)
    MD5Checksum = 'c26dd542679b78974757dc564b928c3b' % The MD5 Checksum of the message definition
  end
  
  properties (Access = protected)
    JavaMessage % The Java message object
  end
  
  properties (Constant, Access = protected)
    StdMsgsHeaderClass = robotics.ros.msg.internal.MessageFactory.getClassForType('std_msgs/Header') % Dispatch to MATLAB class for message type std_msgs/Header
  end
  
  properties (Dependent)
    Header
    Distance
    Angle
  end
  
  properties (Access = protected)
    Cache = struct('Header', []) % The cache for fast data access
  end
  
  properties (Constant, Hidden)
    PropertyList = {'Angle', 'Distance', 'Header'} % List of non-constant message properties
    ROSPropertyList = {'angle', 'distance', 'header'} % List of non-constant ROS message properties
  end
  
  methods
    function obj = VisualServoObject(msg)
      %VisualServoObject Construct the message object VisualServoObject
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
      validateattributes(header, {obj.StdMsgsHeaderClass}, {'nonempty', 'scalar'}, 'VisualServoObject', 'Header');
      
      obj.JavaMessage.setHeader(header.getJavaObject);
      
      % Update cache if necessary
      if ~isempty(obj.Cache.Header)
        obj.Cache.Header.setJavaObject(header.getJavaObject);
      end
    end
    
    function distance = get.Distance(obj)
      %get.Distance Get the value for property Distance
      distance = single(obj.JavaMessage.getDistance);
    end
    
    function set.Distance(obj, distance)
      %set.Distance Set the value for property Distance
      validateattributes(distance, {'numeric'}, {'nonempty', 'scalar'}, 'VisualServoObject', 'Distance');
      
      obj.JavaMessage.setDistance(distance);
    end
    
    function angle = get.Angle(obj)
      %get.Angle Get the value for property Angle
      angle = single(obj.JavaMessage.getAngle);
    end
    
    function set.Angle(obj, angle)
      %set.Angle Set the value for property Angle
      validateattributes(angle, {'numeric'}, {'nonempty', 'scalar'}, 'VisualServoObject', 'Angle');
      
      obj.JavaMessage.setAngle(angle);
    end
  end
  
  methods (Access = protected)
    function resetCache(obj)
      %resetCache Resets any cached properties
      obj.Cache.Header = [];
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
      cpObj.Distance = obj.Distance;
      cpObj.Angle = obj.Angle;
      
      % Recursively copy compound properties
      cpObj.Header = copy(obj.Header);
    end
    
    function reload(obj, strObj)
      %reload Called by loadobj to assign properties
      obj.Distance = strObj.Distance;
      obj.Angle = strObj.Angle;
      obj.Header = feval([obj.StdMsgsHeaderClass '.loadobj'], strObj.Header);
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
      
      strObj.Distance = obj.Distance;
      strObj.Angle = obj.Angle;
      strObj.Header = saveobj(obj.Header);
    end
  end
  
  methods (Static, Access = {?matlab.unittest.TestCase, ?robotics.ros.Message})
    function obj = loadobj(strObj)
      %loadobj Implements loading of message from MAT file
      
      % Return an empty object array if the structure element is not defined
      if isempty(strObj)
        obj = robotics.ros.custom.msggen.trimbot_msgs.VisualServoObject.empty(0,1);
        return
      end
      
      % Create an empty message object
      obj = robotics.ros.custom.msggen.trimbot_msgs.VisualServoObject;
      obj.reload(strObj);
    end
  end
end
