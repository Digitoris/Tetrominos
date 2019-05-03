function pieces = setupPieces()
pieces = struct();

pieces(1).shape = [1 0; 1 1];
pieces(1).corner = 0;

pieces(2).shape = [1 1 1; 0 1 0];
pieces(2).corner = 1;

pieces(3).shape = [1 1 0; 0 1 1; 0 0 1];
pieces(3).corner = 0;

pieces(4).shape = [1 1; 0 1; 0 1; 0 1];
pieces(4).corner = 0;

pieces(5).shape = [0 0 1; 1 1 1; 1 0 0];
pieces(5).corner = 0;

pieces(6).shape = [0 1; 0 1; 1 1; 1 0];
pieces(6).corner = 0;

pieces(7).shape = [1 0; 1 1; 1 0; 1 0];
pieces(7).corner = 1;

pieces(8).shape = [1 0; 1 0; 1 1; 0 1];
pieces(8).corner = 0;

pieces(9).shape = [0 1 1; 0 1 0; 1 1 0];
pieces(9).corner = 1;

pieces(10).shape = [0 1; 0 1; 0 1; 1 1];
pieces(10).corner = 1;

pieces(11).shape = [0 1; 1 1; 1 0];
pieces(11).corner = 1;

pieces(12).shape = [1 0; 1 0; 1 1];
pieces(12).corner = 1;

pieces(13).shape = [0 0 1 0; 1 1 1 1];
pieces(13).corner = 0;

pieces(14).shape = [0 1; 0 1; 1 1];
pieces(14).corner = 1;

for i = 1:numel(pieces)
    pieces(i).corner = boolean(pieces(i).corner);
    pieces(i).shape = boolean(pieces(i).shape);
    pieces(i).size = size(pieces(i).shape);
    pieces(i).blocks = sum(pieces(i).shape(:));
    pieces(i).orientation = 0;
    pieces(i).symmetry = 4;
    
    tempPiece = rotatePiece(pieces(i),2);
    if all(tempPiece.size == pieces(i).size) && all(tempPiece.shape(:)==pieces(i).shape(:))
        pieces(i).symmetry = pieces(i).symmetry/2;
    end
    
    tempPiece = rotatePiece(pieces(i),1);
    if all(tempPiece.size == pieces(i).size) && all(tempPiece.shape(:)==pieces(i).shape(:))
        pieces(i).symmetry = pieces(i).symmetry/2;
    end
end
end