function corners = analyzeCorners(pieces)
corners = cell(4,2);
for ip = 1:numel(pieces)
    c = [pieces(ip).shape{1}(1,1);
        pieces(ip).shape{1}(1,end);
        pieces(ip).shape{1}(end,end);
        pieces(ip).shape{1}(end,1)];

    for ic = 1:4
        if c(ic)
            for i = 1:4
                cIdx = mod(ic+i-1,4)+1;
                corners{i,pieces(ip).corner{cIdx}+1}(end+1,:) = [pieces(ip).id cIdx];
            end
        end
    end
end
end