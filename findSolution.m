function [solutions] = findSolution(pieces,board,allSolutions)
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
    if isempty(pieces(i).id) || numel(pieces(i).id) > 1 || ~isnumeric(pieces(i).id) || pieces(i).id < 1 || fix(pieces(i).id) ~= pieces(i).id
        msg = sprintf('Invalid entry: piece(%i).id\\n',i);
        dataErrorMsg = [dataErrorMsg msg];
    end
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

solutionIdx = 0;
solutions = struct('id',{},'x',{},'y',{});

clear('dataErrorMsg','structErrorMsg','totalBlocks','i')
%% Analyze corners

% Analyze the pieces on corner fit
cornerOptions = cell(2,2,2);
for i = 1:numel(pieces)
    cornerAnalysis = analyzeCorners(pieces(i));
    for ix = 1:2
        for iy = 1:2
            if cornerAnalysis(iy,ix) ~= -1
                cornerOptions{iy,ix,cornerAnalysis(iy,ix)+1}(end+1) = pieces(i).id;
            end
        end
    end
end

% See if the boards color is already set by the current selection, or if a
% corner has no options
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

% Apply the newfound solution to finalize corner selection
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
%% Loop trough corners
if ~allSolutions
    [~,cornerOrder] = sort(cellfun(@length,corners(:)));
else
    cornerOrder = 1:4;
end

remainingPieces = [pieces.id];

for i = 1:4
    cornerSelection = corners{cornerOrder(i)};
        
    for cornerID = cornerSelection
        solution.id = cornerID;
        solution.x = mod(cornerOrder(i)+1,2)*(board.size(2) - pieces(cornerID).size(2));
        solution.y = (cornerOrder(i) > 2)*(board.size(1) - pieces(cornerID).size(1));
        solution.board = board;
        if isempty(solution.board.corner)
            solution.board.corner =  mod(pieces(cornerID).corner + solution.x + solution.y,2);
        end
        
        [~,boardData] = testSolution(solution,board,pieces);
        tempRemainingPieces = remainingPieces(remainingPieces ~= cornerID);
        
        solutionSet = recurse(solution,pieces,boardData,tempRemainingPieces,1,1);
        if ~isempty(solutionSet)
            solutionIdx = solutionIdx + 1;
            solutions(solutionIdx).board = solution.board;
            solutions(solutionIdx).set = solutionSet;
        end
    end
end

%% Finalize
end