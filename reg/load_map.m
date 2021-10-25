function [handles, root] = load_map(filePath)
%% read map from xml file
root = xml_read(filePath);
%% load map objects
handles = ReadLabels('../yaml',struct()); %ResetMap(handles, root.Range);
handles.transAlpha = 0.5;
handles.shapes.Unknown = 0;
handles.shapes.Cuboid = 1;
handles.shapes.Ellipsoid = 2;
handles.shapes.Cylinder = 3;
handles.shapes.Cone = 4;
% mesh
root.Terrain.Vertices(:,3) = - 2;
handles.mesh = patch('Vertices',root.Terrain.Vertices,'Faces',root.Terrain.Faces, 'FaceVertexCData',root.Terrain.FaceLabels, ...
  'FaceColor', 'flat', 'CDataMapping','direct',  'FaceAlpha', handles.transAlpha, 'EdgeAlpha',0, 'PickableParts','none');
hold on; colormap(handles.labelColors);

handles.objects = {};
for id = 1:length(root.Objects)
  props = root.Objects(id);
  props.pos(3) = -2;
  handles.objects{props.id} = DrawObject(handles, props.shape, props);
end


function obj = DrawObject(handles, shape, props)
%% draw map object with given parameters
switch shape
  case handles.shapes.Cuboid
    obj = drawCuboid([props.pos(1) props.pos(2) props.pos(3)+props.diam(3)/2 props.diam props.orient], ...
      'Tag', 'Cuboid');
    
  case handles.shapes.Ellipsoid
    obj = drawEllipsoid([props.pos(1) props.pos(2) props.pos(3)+props.diam(3)/2 props.diam/2 props.orient], ...
      'Tag', 'Ellipsoid', 'LineStyle','-','EdgeColor','k', 'EdgeAlpha',0.5);
    
  case handles.shapes.Cylinder
    obj = drawEllipseCylinder([props.pos(1) props.pos(2) props.pos(3) props.pos(1) props.pos(2) props.pos(3)+props.diam(3) props.diam(1)/2 props.diam(2)/2 props.orient(1)],'closed', ...
      'Tag', 'Cylinder', 'LineStyle','-', 'EdgeColor','k', 'EdgeAlpha',0.5);
    
  case handles.shapes.Cone
    if props.diam(1)==props.diam(2)
      props.diam(2) = 0;
    end
    obj = drawCone([props.pos(1) props.pos(2) props.pos(3)], [props.pos(1) props.pos(2) props.pos(3)+props.diam(3)], [props.diam(1)/2 props.diam(2)/2], 32,'g',0,1);
    set(obj, 'Tag', 'Cone', 'LineStyle','-', 'EdgeColor','k', 'EdgeAlpha',0.5);
    
end
obj.FaceColor = handles.labelColors(props.label,:);
obj.FaceAlpha = handles.transAlpha;
obj.EdgeAlpha = 0;
props.shape = shape;
obj.UserData = props;
