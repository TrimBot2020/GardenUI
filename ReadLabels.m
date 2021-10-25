function handles = ReadLabels( dir, handles )
%READLABELS Read semantic shape labels and colors into handles struct
%           from yaml files in dir
%   labelNames
%   labelIDs
%   labelColors
%% read labels
handles.colors = YAML.read(fullfile(dir, 'colors.yaml'));
handles.labels = YAML.read(fullfile(dir, 'labels.yaml'));
groupNames = fieldnames(handles.labels.Semantic);
id = 1;
for g = 1:length(groupNames)
  gn = groupNames{g};
  gel = handles.labels.Semantic.(gn);
  if isstruct(gel)
    groupLabels = fieldnames(gel);
    for gi = 1:length(groupLabels)
      gl = groupLabels{gi};
      handles.labelNames{id} = [gn '-' gl];
      handles.labelIDs(id) = handles.labels.Semantic.(gn).(gl);
      handles.labelColors(id,1:3) = handles.colors.Semantic.(gn).(gl);
      id = id + 1;
    end
  else
    handles.labelNames{id} = gn;
    handles.labelIDs(id) = handles.labels.Semantic.(gn);
    handles.labelColors(id,1:3) = handles.colors.Semantic.(gn);
    id = id + 1;
  end
end