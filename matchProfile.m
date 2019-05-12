function [y,x] = matchProfile(profiles,piece,rot)
y = zeros(piece.blocks*numel(profiles),1);
x = y;
flag = false(4,1);
nMatches = 0;

for iProfile = 1:numel(profiles)
    for iBlock = 1:piece.blocks
        color = mod(piece.corner{rot} + piece.xData{rot}(iBlock) + piece.yData{rot}(iBlock),2);
        if color == profiles(iProfile).color
            flag(1) = piece.yData{rot}(iBlock) == 1 || ~piece.shape{rot}(piece.yData{rot}(iBlock)-1,piece.xData{rot}(iBlock));
            flag(2) = piece.yData{rot}(iBlock) == piece.size{rot}(1) ||  ~piece.shape{rot}(piece.yData{rot}(iBlock)+1,piece.xData{rot}(iBlock));
            flag(3) = piece.xData{rot}(iBlock) == 1 || ~piece.shape{rot}(piece.yData{rot}(iBlock),piece.xData{rot}(iBlock)-1);
            flag(4) = piece.xData{rot}(iBlock) == piece.size{rot}(2) || ~piece.shape{rot}(piece.yData{rot}(iBlock),piece.xData{rot}(iBlock)+1);

            if all(and(flag,profiles(iProfile).constraints)==profiles(iProfile).constraints)
                newY = profiles(iProfile).y - (piece.yData{rot}(iBlock)-1);
                newX = profiles(iProfile).x - (piece.xData{rot}(iBlock)-1);
                I = find(y(1:nMatches) == newY);
                new = true;
                for matchIdx = I
                    if x(I) == newX
                        new = false;
                        break
                    end
                end
                if new
                    nMatches = nMatches+1;
                    y(nMatches) = newY;
                    x(nMatches) = newX;
                end
            end
        end
    end
end

y = y(1:nMatches);
x = x(1:nMatches);
end