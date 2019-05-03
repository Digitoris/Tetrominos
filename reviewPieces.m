function reviewPieces(pieces)
% Draws all pieces in the set 'pieces', one by one
for i = 1:numel(pieces)
    plotPiece(pieces(i),1)
    pause
end
end