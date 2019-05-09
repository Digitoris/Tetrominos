function isUnique = isUniqueSolution(set,solution)
isUnique = true;
for j = 1:numel(set)
    isUnique = false;
    for i = 1:numel(solution.id)
        Idx = find(set(j).id == solution.id(i),1);
        xUnique = solution.x(i) ~= set(j).x(Idx);
        yUnique = solution.y(i) ~= set(j).y(Idx);
        if xUnique || yUnique
            isUnique = true;
        end
    end
    if ~isUnique
        return
    end
end
end