function [y,x] = matchProfile(profiles,piece)
y = zeros(piece.blocks*numel(profiles),1);
x = y;
flag = false(4,1);
i = 0;

shape = constructShape(piece);
for pIdx = 1:numel(profiles)
    for ib = 1:piece.blocks
        color = mod(piece.corner + piece.xData(ib) + piece.yData(ib),2);
        if color == profiles(pIdx).color
            flag(1) = piece.yData(ib) == 1 || ~shape(piece.yData(ib)-1,piece.xData(ib));
            flag(2) = piece.yData(ib) == piece.size(1) ||  ~shape(piece.yData(ib)+1,piece.xData(ib));
            flag(3) = piece.xData(ib) == 1 || ~shape(piece.yData(ib),piece.xData(ib)-1);
            flag(4) = piece.xData(ib) == piece.size(2) || ~shape(piece.yData(ib),piece.xData(ib)+1);

            if all(and(flag,profiles(pIdx).constraints)==profiles(pIdx).constraints)
                newY = profiles(pIdx).y - (piece.yData(ib)-1);
                newX = profiles(pIdx).x - (piece.xData(ib)-1);
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