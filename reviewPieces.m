function reviewPieces(pieces)
% Draws all pieces in the set 'pieces', one by one
for i = 1:numel(pieces)
    drawPiece(pieces(i),'fid',1)
    pause
end
end