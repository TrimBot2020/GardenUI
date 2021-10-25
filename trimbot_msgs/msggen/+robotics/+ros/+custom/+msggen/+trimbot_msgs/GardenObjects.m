classdef GardenObjects < robotics.ros.Message
  %GardenObjects MATLAB implementation of trimbot_msgs/GardenObjects
  %   This class was automatically generated by
  %   robotics.ros.msg.internal.gen.MessageClassGenerator.
  
  %   Copyright 2014-2019 The MathWorks, Inc.
  
  %#ok<*INUSD>
  
  properties (Constant)
    MessageType = 'trimbot_msgs/GardenObjects' % The ROS message type
  end
  
  properties (Constant, Hidden)
    MD5Checksum = '9353cac751a8cf94427a9d50fd85768e' % The MD5 Checksum of the message definition
  end
  
  properties (Access = protected)
    JavaMessage % The Java message object
  end
  
  properties (Constant, Access = protected)
    TrimbotMsgsGardenObjectClass = robotics.ros.msg.internal.MessageFactory.getClassForType('trimbot_msgs/GardenObject') % Dispatch to MATLAB class for message type trimbot_msgs/GardenObject
  end
  
  properties (Dependent)
    Items
  end
  
  properties (Access = protected)
    Cache = struct('Items', []) % The cache for fast data access
  end
  
  properties (Constant, Hidden)
    PropertyList = {'Items'} % List of non-constant message properties
    ROSPropertyList = {'items'} % List of non-constant ROS message properties
  end
  
  methods
    function obj = GardenObjects(msg)
      %GardenObjects Construct the message object GardenObjects
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
    
    function items = get.Items(obj)
      %get.Items Get the value for property Items
      if isempty(obj.Cache.Items)
        javaArray = obj.JavaMessage.getItems;
        array = obj.readJavaArray(javaArray, obj.TrimbotMsgsGardenObjectClass);
        obj.Cache.Items = feval(obj.TrimbotMsgsGardenObjectClass, array);
      end
      items = obj.Cache.Items;
    end
    
    function set.Items(obj, items)
      %set.Items Set the value for property Items
      if ~isvector(items) && isempty(items)
        % Allow empty [] input
        items = feval([obj.TrimbotMsgsGardenObjectClass '.empty'], 0, 1);
      end
      
      validateattributes(items, {obj.TrimbotMsgsGardenObjectClass}, {'vector'}, 'GardenObjects', 'Items');
      
      javaArray = obj.JavaMessage.getItems;
      array = obj.writeJavaArray(items, javaArray, obj.TrimbotMsgsGardenObjectClass);
      obj.JavaMessage.setItems(array);
      
      % Update cache if necessary
      if ~isempty(obj.Cache.Items)
        obj.Cache.Items = [];
        obj.Cache.Items = obj.Items;
      end
    end
  end
  
  methods (Access = protected)
    function resetCache(obj)
      %resetCache Resets any cached properties
      obj.Cache.Items = [];
    end
    
    function cpObj = copyElement(obj)
      %copyElement Implements deep copy behavior for message
      
      % Call default copy method for shallow copy
      cpObj = copyElement@robotics.ros.Message(obj);
      
      % Clear any existing cached properties
      cpObj.resetCache;
      
      % Create a new Java message object
      cpObj.JavaMessage = obj.createNewJavaMessage;
      
      % Recursively copy compound properties
      cpObj.Items = copy(obj.Items);
    end
    
    function reload(obj, strObj)
      %reload Called by loadobj to assign properties
      ItemsCell = arrayfun(@(x) feval([obj.TrimbotMsgsGardenObjectClass '.loadobj'], x), strObj.Items, 'UniformOutput', false);
      obj.Items = vertcat(ItemsCell{:});
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
      
      strObj.Items = arrayfun(@(x) saveobj(x), obj.Items);
    end
  end
  
  methods (Static, Access = {?matlab.unittest.TestCase, ?robotics.ros.Message})
    function obj = loadobj(strObj)
      %loadobj Implements loading of message from MAT file
      
      % Return an empty object array if the structure element is not defined
      if isempty(strObj)
        obj = robotics.ros.custom.msggen.trimbot_msgs.GardenObjects.empty(0,1);
        return
      end
      
      % Create an empty message object
      obj = robotics.ros.custom.msggen.trimbot_msgs.GardenObjects;
      obj.reload(strObj);
    end
  end
end
