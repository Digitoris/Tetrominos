function piece = rotatePiece(piece,n)
if nargin == 1
    n = 1;
else
    n = mod(n,4);
end

piece.orientation = mod(piece.orientation + n,4);
for i = 1:n
    piece.corner = piece.corner == mod(piece.size(mod(i,2)+1),2);
end
piece.shape = rot90(piece.shape,n);
piece.size = size(piece.shape);
end