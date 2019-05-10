function perimeter = getPerimeter(boardData,solution,pieces,n)
perimeter.y = zeros(3*pieces(solution.id(n)).blocks,1);
perimeter.x = zeros(3*pieces(solution.id(n)).blocks,1);
perimeterData = false(size(boardData));
xOff = [-1 0 1 0];
yOff = [0 1 0 -1];

m = 0;
x = pieces(solution.id(n)).xData{solution.rot(n)} + solution.x(n);
y = pieces(solution.id(n)).yData{solutoin.rot(n)} + solution.y(n);
for b = 1:pieces(solution.id(n)).blocks
    for i = 1:4
        yNew = y(b)+yOff(i);
        xNew = x(b)+xOff(i);
        if isInsideBoard(yNew,xNew,size(boardData)) && boardData(yNew,xNew) == 0 && ~perimeterData(yNew,xNew)
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

function result = isInsideBoard(y,x,boardSize)
    result = (y > 0) && (x > 0) && (y <= boardSize(1)) && (x <= boardSize(2));
end