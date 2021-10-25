classdef CustomMsgConsts
  %CustomMsgConsts This class stores all message types
  %   The message types are constant properties, which in turn resolve
  %   to the strings of the actual types.
  
  %   Copyright 2014-2019 The MathWorks, Inc.
  
  properties (Constant)
    trimbot_msgs_DenseCloud = 'trimbot_msgs/DenseCloud'
    trimbot_msgs_Feature = 'trimbot_msgs/Feature'
    trimbot_msgs_FeatureList = 'trimbot_msgs/FeatureList'
    trimbot_msgs_Flow = 'trimbot_msgs/Flow'
    trimbot_msgs_GardenObject = 'trimbot_msgs/GardenObject'
    trimbot_msgs_GardenObjects = 'trimbot_msgs/GardenObjects'
    trimbot_msgs_Intrinsic = 'trimbot_msgs/Intrinsic'
    trimbot_msgs_MapObject = 'trimbot_msgs/MapObject'
    trimbot_msgs_MapObjects = 'trimbot_msgs/MapObjects'
    trimbot_msgs_MeshEx = 'trimbot_msgs/MeshEx'
    trimbot_msgs_ProtoObject = 'trimbot_msgs/ProtoObject'
    trimbot_msgs_ProtoObjects = 'trimbot_msgs/ProtoObjects'
    trimbot_msgs_Segments = 'trimbot_msgs/Segments'
    trimbot_msgs_SparseCloud = 'trimbot_msgs/SparseCloud'
    trimbot_msgs_VisualServoObject = 'trimbot_msgs/VisualServoObject'
    trimbot_msgs_Volume = 'trimbot_msgs/Volume'
  end
  
  methods (Static, Hidden)
    function messageList = getMessageList
      %getMessageList Generate a cell array with all message types.
      %   The list will be sorted alphabetically.
      
      persistent msgList
      if isempty(msgList)
        msgList = cell(16, 1);
        msgList{1} = 'trimbot_msgs/DenseCloud';
        msgList{2} = 'trimbot_msgs/Feature';
        msgList{3} = 'trimbot_msgs/FeatureList';
        msgList{4} = 'trimbot_msgs/Flow';
        msgList{5} = 'trimbot_msgs/GardenObject';
        msgList{6} = 'trimbot_msgs/GardenObjects';
        msgList{7} = 'trimbot_msgs/Intrinsic';
        msgList{8} = 'trimbot_msgs/MapObject';
        msgList{9} = 'trimbot_msgs/MapObjects';
        msgList{10} = 'trimbot_msgs/MeshEx';
        msgList{11} = 'trimbot_msgs/ProtoObject';
        msgList{12} = 'trimbot_msgs/ProtoObjects';
        msgList{13} = 'trimbot_msgs/Segments';
        msgList{14} = 'trimbot_msgs/SparseCloud';
        msgList{15} = 'trimbot_msgs/VisualServoObject';
        msgList{16} = 'trimbot_msgs/Volume';
      end
      
      messageList = msgList;
    end
    
    function serviceList = getServiceList
      %getServiceList Generate a cell array with all service types.
      %   The list will be sorted alphabetically.
      
      persistent svcList
      if isempty(svcList)
        svcList = cell(0, 1);
      end
      
      % The message list was already sorted, so don't need to sort
      % again.
      serviceList = svcList;
    end
    
    function actionList = getActionList
      %getActionList Generate a cell array with all action types.
      %   The list will be sorted alphabetically.
      
      persistent actList
      if isempty(actList)
        actList = cell(0, 1);
      end
      
      % The message list was already sorted, so don't need to sort
      % again.
      actionList = actList;
    end
  end
end
