function [y,x] = matchProfile(profile,piece)
y = zeros(piece.blocks,1);
x = y;
flag = false(4,1);
i = 0;

shape = constructShape(piece);
for ib = 1:piece.blocks
    color = mod(piece.corner + piece.xData(ib) + piece.yData(ib),2);
    if color == profile.color
        flag(1) = piece.yData(ib) == 1 || ~shape(piece.yData(ib)-1,piece.xData(ib));
        flag(2) = piece.yData(ib) == piece.size(1) ||  ~shape(piece.yData(ib)+1,piece.xData(ib));
        flag(3) = piece.xData(ib) == 1 || ~shape(piece.yData(ib),piece.xData(ib)-1);
        flag(4) = piece.xData(ib) == piece.size(2) || ~shape(piece.yData(ib),piece.xData(ib)+1);
        
        if all(and(flag,profile.constraints)==profile.constraints)
            i = i+1;
            y(i) = piece.yData(ib)-1;
            x(i) = piece.xData(ib)-1;
        end
    end
end

y = y(1:i);
x = x(1:i);
end