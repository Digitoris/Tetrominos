function [y,x] = matchProfile(profiles,piece,rot)
y = zeros(piece.blocks*numel(profiles),1);
x = y;
flag = false(4,1);
i = 0;

for pIdx = 1:numel(profiles)
    for ib = 1:piece.blocks
        color = mod(piece.corner{rot} + piece.xData{rot}(ib) + piece.yData{rot}(ib),2);
        if color == profiles(pIdx).color
            flag(1) = piece.yData{rot}(ib) == 1 || ~piece.shape{rot}(piece.yData{rot}(ib)-1,piece.xData{rot}(ib));
            flag(2) = piece.yData{rot}(ib) == piece.size{rot}(1) ||  ~piece.shape{rot}(piece.yData{rot}(ib)+1,piece.xData{rot}(ib));
            flag(3) = piece.xData{rot}(ib) == 1 || ~piece.shape{rot}(piece.yData{rot}(ib),piece.xData{rot}(ib)-1);
            flag(4) = piece.xData{rot}(ib) == piece.size{rot}(2) || ~piece.shape{rot}(piece.yData{rot}(ib),piece.xData{rot}(ib)+1);

            if all(and(flag,profiles(pIdx).constraints)==profiles(pIdx).constraints)
                newY = profiles(pIdx).y - (piece.yData{rot}(ib)-1);
                newX = profiles(pIdx).x - (piece.xData{rot}(ib)-1);
                I = find(y(1:i) == newY);
                new = true;
                for matchIdx = I
                    if x(I) == newX
                        new = false;
                        break
                    end
                end
                if new
                    i = i+1;
                    y(i) = newY;
                    x(i) = newX;
                end
            end
        end
    end
end

y = y(1:i);
x = x(1:i);
end