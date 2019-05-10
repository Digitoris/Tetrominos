function shape = constructShape(piece)
shape = false([max(piece.yData) max(piece.xData)]);
for i = 1:numel(piece.yData)
    shape(piece.yData(i),piece.xData(i)) = true;
end 
end