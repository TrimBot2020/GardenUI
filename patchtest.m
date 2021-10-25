function p = patchtest()

figure;

%The Vertices property contains the coordinates of each
% unique vertex defining the patch. The Faces property 
% specifies how to connect these vertices to form each
% face of the patch. More than one face may 
% use a given vertex.
% For this example, five triangles have 11 total vertices, 
% instead of 15. Each row contains 
% the x- and y-coordinates 
% of each vertex.
verts = [2 4; ...
        2 8; ...
        8 4; ...
        8 0; ...
        0 4; ...
        2 6; ...
        2 2; ...
        4 2; ...
        4 0; ...
        5 2; ...
        5 0 ];

% There are five faces, defined by connecting the 
% vertices in the order indicated.
faces = [ ...
        1  2  3; ...
        1  3  4; ...
        5  6  1; ...
        7  8  9; ...
        11 10 4 ];

% Create the patch by specifying the Faces, Vertices,
% and FaceVertexCData properties as well as the
% FaceColor property. Red numbers denote the vertex 
% numbers, as defined in faces. Blue indicate face numbers.
p = patch('Faces',faces,'Vertices',verts,'FaceColor','w','ButtonDownFcn',@PatchClickedFcn);

line(4,2,'marker','s');

% Using the previous values for verts and faces, you can 
% create the same patch object using a structure: 
% patchinfo.Vertices = verts;
% patchinfo.Faces = faces;
% patchinfo.FaceColor = 'w';
% 
% patch(patchinfo);

%%
function PatchClickedFcn(hObject, eventdata, handles)

disp(eventdata);
