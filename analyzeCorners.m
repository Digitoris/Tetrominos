function corners = analyzeCorners(piece)
corners = -ones(2,2);

for ix = 1:2
    dx = (ix-1)*(piece.size(2)-1);
    for iy = 1:2
        dy = (iy-1)*(piece.size(1)-1);
        if piece.shape(1+dy,1+dx)
            corners(iy,ix) = mod(piece.corner + dx + dy,2);
        end
    end
end

% if piece.shape(1,1)
%     if piece.corner == 0
%         white(1,1) = true;
%     else
%         green(1,1) = true;
%     end
% end
% 
% if piece.shape(1,end) 
%     if mod(piece.corner+piece.size(2)-1,2) == 0
%         white(1,end) = true;
%     else
%         green(1,end) = true;
%     end
% end
% 
% if piece.shape(end,1) 
%     if mod(piece.corner+piece.size(1)-1,2) == 0
%         white(end,1) = true;
%     else
%         green(end,1) = true;
%     end
% end
% 
% if piece.shape(end,end) 
%     if mod(piece.corner+piece.size(2)+piece.size(1)-2,2) == 0
%         white(end,end) = true;
%     else
%         green(end,end) = true;
%     end
% end
    
end