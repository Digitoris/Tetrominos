function [white,green] = analyzeCorners(piece)
white = false(2,2);
green = white;

if piece.shape(1,1)
    if piece.corner == 0
        white(1,1) = true;
    else
        green(1,1) = true;
    end
end

if piece.shape(1,end) 
    if mod(piece.corner+piece.size(2)-1,2) == 0
        white(1,end) = true;
    else
        green(1,end) = true;
    end
end

if piece.shape(end,1) 
    if mod(piece.corner+piece.size(1)-1,2) == 0
        white(end,1) = true;
    else
        green(end,1) = true;
    end
end

if piece.shape(end,end) 
    if mod(piece.corner+piece.size(2)+piece.size(1)-2,2) == 0
        white(end,end) = true;
    else
        green(end,end) = true;
    end
end
    
end