classdef Segments < robotics.ros.Message
  %Segments MATLAB implementation of trimbot_msgs/Segments
  %   This class was automatically generated by
  %   robotics.ros.msg.internal.gen.MessageClassGenerator.
  
  %   Copyright 2014-2019 The MathWorks, Inc.
  
  %#ok<*INUSD>
  
  properties (Constant)
    MessageType = 'trimbot_msgs/Segments' % The ROS message type
  end
  
  properties (Constant, Hidden)
    MD5Checksum = '98745680f5d9d9dec0e5a9d00c871fac' % The MD5 Checksum of the message definition
  end
  
  properties (Access = protected)
    JavaMessage % The Java message object
  end
  
  properties (Constant, Access = protected)
    StdMsgsHeaderClass = robotics.ros.msg.internal.MessageFactory.getClassForType('std_msgs/Header') % Dispatch to MATLAB class for message type std_msgs/Header
  end
  
  properties (Dependent)
    Header
    Id
    Frame
    Count
    Seg
    Label
    Shape
  end
  
  properties (Access = protected)
    Cache = struct('Header', []) % The cache for fast data access
  end
  
  properties (Constant, Hidden)
    PropertyList = {'Count', 'Frame', 'Header', 'Id', 'Label', 'Seg', 'Shape'} % List of non-constant message properties
    ROSPropertyList = {'count', 'frame', 'header', 'id', 'label', 'seg', 'shape'} % List of non-constant ROS message properties
  end
  
  methods
    function obj = Segments(msg)
      %Segments Construct the message object Segments
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
      validateattributes(header, {obj.StdMsgsHeaderClass}, {'nonempty', 'scalar'}, 'Segments', 'Header');
      
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
      validateattributes(id, {'numeric'}, {'nonempty', 'scalar'}, 'Segments', 'Id');
      
      obj.JavaMessage.setId(id);
    end
    
    function frame = get.Frame(obj)
      %get.Frame Get the value for property Frame
      frame = typecast(int32(obj.JavaMessage.getFrame), 'uint32');
    end
    
    function set.Frame(obj, frame)
      %set.Frame Set the value for property Frame
      validateattributes(frame, {'numeric'}, {'nonempty', 'scalar'}, 'Segments', 'Frame');
      
      obj.JavaMessage.setFrame(frame);
    end
    
    function count = get.Count(obj)
      %get.Count Get the value for property Count
      count = typecast(int32(obj.JavaMessage.getCount), 'uint32');
    end
    
    function set.Count(obj, count)
      %set.Count Set the value for property Count
      validateattributes(count, {'numeric'}, {'nonempty', 'scalar'}, 'Segments', 'Count');
      
      obj.JavaMessage.setCount(count);
    end
    
    function seg = get.Seg(obj)
      %get.Seg Get the value for property Seg
      javaArray = obj.JavaMessage.getSeg;
      array = obj.readJavaArray(javaArray, 'uint32');
      seg = uint32(array);
    end
    
    function set.Seg(obj, seg)
      %set.Seg Set the value for property Seg
      if ~isvector(seg) && isempty(seg)
        % Allow empty [] input
        seg = uint32.empty(0,1);
      end
      
      validateattributes(seg, {'numeric'}, {'vector'}, 'Segments', 'Seg');
      
      javaArray = obj.JavaMessage.getSeg;
      array = obj.writeJavaArray(seg, javaArray, 'uint32');
      obj.JavaMessage.setSeg(array);
    end
    
    function label = get.Label(obj)
      %get.Label Get the value for property Label
      javaArray = obj.JavaMessage.getLabel;
      array = obj.readJavaArray(javaArray, 'uint32');
      label = uint32(array);
    end
    
    function set.Label(obj, label)
      %set.Label Set the value for property Label
      if ~isvector(label) && isempty(label)
        % Allow empty [] input
        label = uint32.empty(0,1);
      end
      
      validateattributes(label, {'numeric'}, {'vector'}, 'Segments', 'Label');
      
      javaArray = obj.JavaMessage.getLabel;
      array = obj.writeJavaArray(label, javaArray, 'uint32');
      obj.JavaMessage.setLabel(array);
    end
    
    function shape = get.Shape(obj)
      %get.Shape Get the value for property Shape
      javaArray = obj.JavaMessage.getShape;
      array = obj.readJavaArray(javaArray, 'uint32');
      shape = uint32(array);
    end
    
    function set.Shape(obj, shape)
      %set.Shape Set the value for property Shape
      if ~isvector(shape) && isempty(shape)
        % Allow empty [] input
        shape = uint32.empty(0,1);
      end
      
      validateattributes(shape, {'numeric'}, {'vector'}, 'Segments', 'Shape');
      
      javaArray = obj.JavaMessage.getShape;
      array = obj.writeJavaArray(shape, javaArray, 'uint32');
      obj.JavaMessage.setShape(array);
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
      cpObj.Id = obj.Id;
      cpObj.Frame = obj.Frame;
      cpObj.Count = obj.Count;
      cpObj.Seg = obj.Seg;
      cpObj.Label = obj.Label;
      cpObj.Shape = obj.Shape;
      
      % Recursively copy compound properties
      cpObj.Header = copy(obj.Header);
    end
    
    function reload(obj, strObj)
      %reload Called by loadobj to assign properties
      obj.Id = strObj.Id;
      obj.Frame = strObj.Frame;
      obj.Count = strObj.Count;
      obj.Seg = strObj.Seg;
      obj.Label = strObj.Label;
      obj.Shape = strObj.Shape;
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
      
      strObj.Id = obj.Id;
      strObj.Frame = obj.Frame;
      strObj.Count = obj.Count;
      strObj.Seg = obj.Seg;
      strObj.Label = obj.Label;
      strObj.Shape = obj.Shape;
      strObj.Header = saveobj(obj.Header);
    end
  end
  
  methods (Static, Access = {?matlab.unittest.TestCase, ?robotics.ros.Message})
    function obj = loadobj(strObj)
      %loadobj Implements loading of message from MAT file
      
      % Return an empty object array if the structure element is not defined
      if isempty(strObj)
        obj = robotics.ros.custom.msggen.trimbot_msgs.Segments.empty(0,1);
        return
      end
      
      % Create an empty message object
      obj = robotics.ros.custom.msggen.trimbot_msgs.Segments;
      obj.reload(strObj);
    end
  end
end
