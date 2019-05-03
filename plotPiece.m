function plotPiece(piece,fid)
%Plot a piece, as defined in setupPieces in the optionally defined figure
%id fid
if nargin > 1
    figure(fid);
    clf;
else
    figure();
end

daspect([1 1 1])
set(gca, 'Visible', 'off')

for x = 1:piece.size(2)
    for y = 1:piece.size(1)
        if piece.shape(y,x)
            if mod(x + y, 2) ~= piece.corner
                color = [0.44 0.68 0.18];
            else
                color = [1 1 1];
            end
            patch(x + [0 1 1 0],- y - [0 0 1 1 ],color,'EdgeColor',[0 0 0])
        end
    end
end
end