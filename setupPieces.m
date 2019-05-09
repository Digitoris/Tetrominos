function pieces = setupPieces()
%Creates a one-by-n structure for the n pieces, with the following fields:
%   shape           (bool) matrix with true where a piece is filled in,
%                       false where not filled in
%   corner          (bool) True if the top left corner is green, false if
%                       white
%   size            (int)  size(shape), might save computation time later
%   orientation     (int)  0:3 orientation (zero is upwards,
%                       propagates counterclockwise
%   symmetry        (int)  4/2/1 number of rotational symmetry options
%   blocks          (int)  number of squares the shape contains

pieces = struct();

pieces(1).xData = [1 1 2];
pieces(1).yData = [1 2 2];
pieces(1).corner = 0;

pieces(2).xData = [1 2 3 2];
pieces(2).yData = [1 1 1 2];
pieces(2).corner = 1;

pieces(3).xData = [1 2 2 3 3];
pieces(3).yData = [1 1 2 2 3];
pieces(3).corner = 0;

pieces(4).xData = [1 2 2 2 2];
pieces(4).yData = [1 1 2 3 4];
pieces(4).corner = 0;

pieces(5).xData = [3 1 2 3 1];
pieces(5).yData = [1 2 2 2 3];
pieces(5).corner = 0;

pieces(6).xData = [2 2 1 2 1];
pieces(6).yData = [1 2 3 3 4];
pieces(6).corner = 0;

pieces(7).xData = [1 1 1 2 2];
pieces(7).yData = [1 2 3 3 4];
pieces(7).corner = 0;

pieces(8).xData = [1 1 2 1 1];
pieces(8).yData = [1 2 2 3 4];
pieces(8).corner = 1;

pieces(9).xData = [2 2 2 1 2];
pieces(9).yData = [1 2 3 4 4];
pieces(9).corner = 0;

pieces(10).xData = [2 1 2 1];
pieces(10).yData = [1 2 2 3];
pieces(10).corner = 1;

pieces(11).xData = [2 3 2 1 2];
pieces(11).yData = [1 1 2 3 3];
pieces(11).corner = 1;

pieces(12).xData = [1 1 1 2];
pieces(12).yData = [1 2 3 3];
pieces(12).corner = 1;

pieces(13).xData = [2 2 1 2];
pieces(13).yData = [1 2 3 3];
pieces(13).corner = 1;

pieces(14).xData = [3 1 2 3 4];
pieces(14).yData = [1 2 2 2 2];
pieces(14).corner = 0;

for i = 1:numel(pieces)
    pieces(i).corner = boolean(pieces(i).corner);
    pieces(i).size = [max(pieces(i).yData) max(pieces(i).xData)];
    pieces(i).blocks = numel(pieces(i).yData);
    pieces(i).orientation = 0;
    pieces(i).symmetry = 4;
    pieces(i).id = i;
    pieces(i).shape = constructShape(pieces(i));

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