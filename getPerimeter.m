function perimeter = getPerimeter(boardData,solution,n)

perimeter.y = zeros(3*solution.pieces(solution.id(n)).blocks,1);
perimeter.x = zeros(3*solution.pieces(solution.id(n)).blocks,1);
perimeterData = false(solution.board.size);
xOff = [-1 0 1 0];
yOff = [0 1 0 -1];

m = 0;
for b = 1:solution.pieces(solution.id(n)).blocks
    x = solution.pieces(solution.id(n)).xData(b) + solution.x(n);
    y = solution.pieces(solution.id(n)).yData(b) + solution.y(n);
    
    for i = 1:4
        yNew = y+yOff(i);
        xNew = x+xOff(i);
        if isInsideBoard(yNew,xNew,solution.board) && boardData(yNew,xNew) == 0 && ~perimeterData(yNew,xNew)
            m = m + 1;
            perimeterData(yNew,xNew) = true;
            perimeter.y(m) = yNew;
            perimeter.x(m) = xNew;
        end
    end
end
perimeter.y = perimeter.y(1:m);
perimeter.x = perimeter.x(1:m);
end

function result = isInsideBoard(y,x,board)
    result = (y > 0) && (x > 0) && (y <= board.size(1)) && (x <= board.size(2));
end