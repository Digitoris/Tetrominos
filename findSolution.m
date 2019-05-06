function [corners] = findSolution(pieces,board)
%% Setup solution and field
if ~isstruct(pieces)
    error('pieces must be a piece-structure')
elseif ~isstruct(board)
    error('board must be a board-structure')
end

structErrorMsg = '';
structErrorMsg = [structErrorMsg verifyField(pieces,'shape')];
structErrorMsg = [structErrorMsg verifyField(pieces,'corner')];
structErrorMsg = [structErrorMsg verifyField(pieces,'size')];
structErrorMsg = [structErrorMsg verifyField(pieces,'blocks')];
structErrorMsg = [structErrorMsg verifyField(board,'size')];
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
if isempty(board.size) || ~all(size(board.size)== [1 2]) || ~all(isnumeric(board.size)) || ~all(fix(board.size) == board.size) 
    msg = 'Invalid entry: board.size\\n';
    dataErrorMsg = [dataErrorMsg msg];
end
if ~isempty(dataErrorMsg)
    error(sprintf(dataErrorMsg))
end
if totalBlocks ~= prod(board.size)
    error('Number of blocks does not match board size: %i blocks in %i spaces',blocks,prod(board.size))
end

if ~isfield(board,'corner')
    board.corner = [];
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
    dx = (ix-1)*(board.size(2)-1);
    for iy = 1:2
        dy = (iy-1)*(board.size(1)-1);
        for ic = 1:2
            if isempty(cornerOptions{iy,ix,ic})
                cornerColor = mod(ic - dx - dy,2);
                if isempty(board.corner)
                    board.corner = cornerColor;
                elseif board.corner ~= cornerColor
                    error('Impossible corner')
                end
            end
        end
    end
end


if isempty(board.corner)
    corners{iy,ix} = cellfun(@(x,y) [x y],cornerOptions(:,:,1),cornerOptions(:,:,2),'un',0);
else
    corners = cell(2,2);   
    for ix = 1:2
        dx = (ix-1)*(board.size(2)-1);
        for iy = 1:2
            dy = (iy-1)*(board.size(1)-1);
            corners(iy,ix) = cornerOptions(iy,ix,mod(board.corner + dx + dy,2)+1);
        end
    end
end

clear('cornerAnalysis','cornerOptions','cornerColor','dx','dy','i','ic','ix','iy')
%% Eliminate Corners
cornerCounts = cellfun(@length,corners);
[sortedCornerCounts,sortedCornerLocations] = sort(cornerCounts(:));

for i = 1:4
    cornerLocation = sortedCornerLocations(i);
    cornerSelection = corners{cornerLocation};
    remainingPieces = 1:numel(pieces);
    
    n = numel(CornerSelection);
    tempSolution(1:n).id = [];
    tempSolution(1:n).x = [];
    tempSolution(1:n).y = [];
    
    for j = 1:numel(cornerSelection)
        % DO SOMETHING RECURSIVELY
%         %Place corner
%         somewhere.x(someplace) = mod(cornerLocation+1,2)*(board.size(2) - pieces(cornerSelection(j)).size(2));
%         somewhere.y(someplace) = (cornerLocation > 2)*(board.size(1) - pieces(cornerSelection(j)).size(1));
% 
%         somewhere.id(someplace) = cornerSelection(j);
%         
%         %Test options
%         
    end
end


%% Final Cleanup
solution.board = board;
solution.pieces = pieces;
end