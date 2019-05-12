function [result,boardData] = addPiece(boardData,piece,rot,x,y)
result = false;
x = x + piece.xData{rot};
y = y + piece.yData{rot};
if max(x) > size(boardData,2) || max(y) > size(boardData,1) || min(x) < 1 || min(y) < 1
    return
end

for b = 1:piece.blocks
    if boardData(y(b),x(b)) ~= 0
        %fprintf('Solution failed at piece %i [id:%i], overlapping at y,x = %i,%i\n',i,solution.id(i),y,x)
        return;
    end
    boardData(y(b),x(b)) = piece.id;
end
result = true;
end