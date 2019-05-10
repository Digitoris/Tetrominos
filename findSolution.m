function [solutions] = findSolution(board,pieces)
%% Setup solution and field

totalBlocks = 0;
for i = 1:numel(pieces)
    totalBlocks = totalBlocks + pieces(i).blocks;
end
if totalBlocks ~= prod(board.size)
    error('Number of blocks does not match board size: %i blocks in %i spaces',blocks,prod(board.size))
end
if ~isfield(board,'corner')
    board.corner = [];
end

%% Analyze corners
% Analyze the pieces on corner fit
cornerOptions = analyzeCorners(pieces);
[numOpts,optionIdx] = min(cellfun(@numel,cornerOptions(:)));

% See if the boards color is already set by the current selection, or if a
% corner has no options
i = 1;
while i < 8
    if numOpts(i) > 0
        break
    end
    i = i+1;
end
if i == 9
    error('No corner options left')
end

corner = mod(i,4) + 1;
cornerSelection = cornerOptions{optionIdx(i)};
board.corner = i <= size(cornerOptions,1); 

%% Loop trough corners
remainingPieces = [pieces.id];
solutions = struct('id',[],'rot',[],'x',[],'y',[]);
boardData = zeros(board.size);

for cornerIdx = 1:size(cornerSelection,1)
    solution.id = cornerSelection(cornerIdx,1);
    solution.rot = cornerSelection(cornerIdx,2);
    solution.x = (corner > 2)*(board.size(2) - pieces(solution.id).size{solution.rot}(2));
    solution.y = mod(corner+1,2)*(board.size(1) - pieces(solution.id).size{solution.rot}(1));

    [~,newboardData] = addPiece(boardData,pieces,solution.id,solution.rot,solution.x,solution.y);
    newRemainingPieces = remainingPieces(remainingPieces ~= solution.id);

    solutionSet = recurse(solution,pieces,board,newboardData,newRemainingPieces,1,[]);
    fprintf('finished cornerID: %i rot: %i\n',solution.id,solution.rot);
    for n = 1:numel(solutoinSet)
        solutionIdx = solutionIdx + 1;
        solutions(solutionIdx) = solutionSet(n);
    end
end
end