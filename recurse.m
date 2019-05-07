function [out] = recurse(solution,boardData,remainingPieceIDs,n,it)

for m = n:numel(solution.id)
    perimeter = getPerimeter(boardData,solution,m);
    if ~isempty(perimeter.y)
        break
    elseif m == numel(solution.id)
        error("Something went wrong, no perimeters left")
    end
end
perimeterProfiles = createProfiles(boardData,perimeter,solution.board,true);

m = numel(solution.id);
for profile = perimeterProfiles
    for ID = remainingPieceIDs
        [dy,dx] = matchProfile(profile,solution.pieces(ID));
        if isempty(dy)
            continue
        else
            solution.id(m+1) = ID;
            solution.y(m+1) = profile.y - dy;
            solution.x(m+1) = profile.x - dx;
            [result,newBoardData] = testSolution(solution);
            
            if result
                recurse(solution,newBoardData,remainingPieceIDs,solution.id(n),it+1)
            end
        end
    end
end
end
