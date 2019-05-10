function [result,boardData] = testSolution(solution,board,pieces)
result = false;
boardData = zeros(board.size);
for i = 1:numel(solution.id)
    if solution.x(i) < 0 || solution.y(i) < 0
        %fprintf('Solution failed at piece %i [id:%i], exceeding bounds\n',i.solution.id(i));
        return;
    end    
    if any([solution.y(i) solution.x(i)] + pieces(solution.id(i)).size{solution.rot(i)} > board.size)
        %fprintf('Solution failed at piece %i [id:%i], exceeding bounds\n',i,solution.id(i));
        return;
    end
    x = solution.x(i) + pieces(solution.id(i)).xData{solution.rot(i)};
    y = solution.y(i) + pieces(solution.id(i)).yData{solution.rot(1)};
    for b = 1:pieces(solution.id(i)).blocks
        if boardData(y(b),x(b)) ~= 0
            %fprintf('Solution failed at piece %i [id:%i], overlapping at y,x = %i,%i\n',i,solution.id(i),y,x)
            return;
        end
        boardData(y(b),x(b)) = solution.id(i);
    end
end
result = true;
end