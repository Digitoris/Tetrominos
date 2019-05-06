function [y,x] = matchProfile(profile,piece)
y = zeros(piece.blocks,1);
x = y;
flag = false(4,1);
i = 0;

for iy = 1:piece.size(1)
    for ix = 1:piece.size(2)
        color = mod(piece.corner + ix + iy,2);
        if piece.shape(iy,ix) && color == profile.color
            flag(1) = iy == 1 || ~piece.shape(iy-1,ix);
            flag(2) = iy == piece.size(1) ||  ~piece.shape(iy+1,ix);
            flag(3) = ix == 1 || ~piece.shape(iy,ix-1);
            flag(4) = ix == piece.size(2) || ~piece.shape(iy,ix+1);

            if all(and(flag,profile.constraints)==profile.constraints)
                i = i+1;
                y(i) = iy-1;
                x(i) = ix-1;
            end
        end
    end
end

y = y(1:i);
x = x(1:i);
end