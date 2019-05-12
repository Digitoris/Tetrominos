function corners = analyzeCorners(pieces)
corners = cell(4,2);
for iPiece = 1:numel(pieces)
    corners = [pieces(iPiece).shape{1}(1,1);
        pieces(iPiece).shape{1}(1,end);
        pieces(iPiece).shape{1}(end,end);
        pieces(iPiece).shape{1}(end,1)];

    for iCorner = 1:4
        if corners(iCorner)
            for i = 1:4
                cornerIdx = mod(iCorner+i-1,4)+1;
                corners{i,pieces(iPiece).corner{cornerIdx}+1}(end+1,:) = [pieces(iPiece).id cornerIdx];
            end
        end
    end
end
end