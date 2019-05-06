function [corners,cornerOptions] = findSolution(pieces,field)
%% Setup solution and field
if ~isstruct(pieces)
    error('pieces must be a piece-structure')
elseif ~isstruct(field)
    error('field must be a field-structure')
end

structErrorMsg = '';
structErrorMsg = [structErrorMsg verifyField(pieces,'shape')];
structErrorMsg = [structErrorMsg verifyField(pieces,'corner')];
structErrorMsg = [structErrorMsg verifyField(pieces,'size')];
structErrorMsg = [structErrorMsg verifyField(pieces,'blocks')];
structErrorMsg = [structErrorMsg verifyField(field,'size')];
if ~isempty(structErrorMsg)
    error(sprintf(structErrorMsg))
end

dataErrorMsg = '';
totalBlocks = 0;
for i = 1:numel(pieces)
    if isempty(pieces(i).shape) || ~islogical(pieces(i).shape)
        msg = sprintf('Invalid entry: piece(%i).shape\\n',i);
        dataErrorMsg = [dataErrorMsg msg];
    end
    if isempty(pieces(i).corner) || ~any(pieces(i).corner == [0 1])
        msg = sprintf('Invalid entry: piece(%i).corner\\n',i);
        dataErrorMsg = [dataErrorMsg msg];
    end
    if isempty(pieces(i).size) || ~all(size(pieces(i).size)== [1 2]) || ~all(isnumeric(pieces(i).size)) || ~all(fix(pieces(i).size) == pieces(i).size) 
        msg = sprintf('Invalid entry: piece(%i).size\\n',i);
        dataErrorMsg = [dataErrorMsg msg];
    end
    if isempty(pieces(i).blocks) || numel(pieces(i).blocks) > 1 || ~isnumeric(pieces(i).blocks) || pieces(i).blocks < 1 || fix(pieces(i).blocks) ~= pieces(i).blocks
        msg = sprintf('Invalid entry: piece(%i).blocks\\n',i);
        dataErrorMsg = [dataErrorMsg msg];
    else
        totalBlocks = totalBlocks + pieces(i).blocks;
    end
end
if isempty(field.size) || ~all(size(field.size)== [1 2]) || ~all(isnumeric(field.size)) || ~all(fix(field.size) == field.size) 
    msg = ['Invalid entry: field.size\\n'];
    dataErrorMsg = [dataErrorMsg msg];
end
if ~isempty(dataErrorMsg)
    error(sprintf(dataErrorMsg))
end
if totalBlocks ~= prod(field.size)
    error('Number of blocks does not match field size: %i blocks in %i spaces',blocks,prod(field.size))
end

if ~isfield(field,'corner')
    field.corner = [];
end
solution.id = [];
solution.x = [];
solution.y = [];

clear('dataErrorMsg','structErrorMsg','totalBlocks','i')
%% Analyze corners
cornerOptions = cell(2,2,2);

for i = 1:numel(pieces)
    cornerAnalysis = analyzeCorners(pieces(i))+1;
    for ix = 1:2
        for iy = 1:2
            if cornerAnalysis(iy,ix) ~= 0
                cornerOptions{iy,ix,cornerAnalysis(iy,ix)}(end+1) = i;
            end
        end
    end
end

for ix = 1:2
    dx = (ix-1)*(field.size(2)-1);
    for iy = 1:2
        dy = (iy-1)*(field.size(1)-1);
        for ic = 1:2
            if isempty(cornerOptions{iy,ix,ic})
                cornerColor = mod(ic - dx - dy,2);
                if isempty(field.corner)
                    field.corner = cornerColor;
                elseif field.corner ~= cornerColor
                    error('Impossible corner')
                end
            end
        end
    end
end


if isempty(field.corner)
    corners{iy,ix} = cellfun(@(x,y) [x y],cornerOptions(:,:,1),cornerOptions(:,:,2),'un',0);
else
    corners = cell(2,2);   
    for ix = 1:2
        dx = (ix-1)*(field.size(2)-1);
        for iy = 1:2
            dy = (iy-1)*(field.size(1)-1);
            corners(iy,ix) = cornerOptions(iy,ix,mod(field.corner + dx + dy,2)+1);
        end
    end
end

clear('cornerAnalysis','cornerOptions','cornerColor','dx','dy','i','ic','ix','iy')
%% Eliminate Corners

%% Final Cleanup
solution.field = field;
solution.pieces = pieces;
end