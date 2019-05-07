function corners = analyzeCorners(piece)
corners = -ones(2,2);

for b = 1:piece.blocks
    f1 = piece.yData(b) == 1;
    f2 = piece.xData(b) == 1;
    if (piece.yData(b) == 1 || piece.yData(b) == piece.size(1)) && (piece.xData(b) == 1 || piece.xData(b) == piece.size(2))
        corners(~f1+1,~f2+1) = mod(piece.corner + piece.yData(b) + piece.xData(b),2);
    end
end
end