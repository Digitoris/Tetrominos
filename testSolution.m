function [result,boardData] = testSolution(solution,board,pieces)
result = false;
boardData = zeros(board.size);
for i = 1:numel(solution.id)
    piece = pieces(solution.id(i));
    if mod(board.corner + solution.x(i) + solution.y(i),2) ~= piece.corner
        %fprintf('Solution failed at piece %i [id:%i], color mismatch\n',i,solution.id(i));
        return;
    end
    if solution.x(i) < 0 || solution.y(i) < 0
        %fprintf('Solution failed at piece %i [id:%i], exceeding bounds\n',i.solution.id(i));
        return;
    end    
    if any([solution.y(i) solution.x(i)] + piece.size > board.size)
        %fprintf('Solution failed at piece %i [id:%i], exceeding bounds\n',i,solution.id(i));
        return;
    end
    for b = 1:piece.blocks
        x = solution.x(i) + piece.xData(b);
        y = solution.y(i) + piece.yData(b);
        if boardData(y,x) ~= 0
            %fprintf('Solution failed at piece %i [id:%i], overlapping at y,x = %i,%i\n',i,solution.id(i),y,x)
            return;
        end
        boardData(y,x) = solution.id(i);
    end
end
result = true;
if nnz(boardData) == prod(board.size)
    %fprintf('Stable solution found\n');
else
    %fprintf('Partial solution is stable\n');
end
end