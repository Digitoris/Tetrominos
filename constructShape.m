function shape = constructShape(piece)
shape = false(piece.size);
for i = 1:piece.blocks
    shape(piece.yData(i),piece.xData(i)) = true;
end 
end