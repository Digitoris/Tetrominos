function solutionSet = recurse(solution,pieces,boardData,remainingPieceIDs,perimeterIdx)
%% Compose perimeter
for newPerimeterIdx = perimeterIdx:numel(solution.id)
    perimeter = getPerimeter(boardData,solution,pieces,newPerimeterIdx);
    if ~isempty(perimeter.y)
        break
    elseif newPerimeterIdx == numel(solution.id)
        error("Something went wrong, no pieces left for perimeter check")
    end
end
perimeterProfiles = createProfiles(boardData,perimeter,solution.board,true);

%% Actual recursion
solutionSet = struct('id',{},'x',{},'y',{});
solutionIdx = 0;
freePieceIdx = numel(solution.id)+1;
for ID = remainingPieceIDs
    solution.id(freePieceIdx) = ID;
    [y,x] = matchProfile(perimeterProfiles,pieces(ID));
    for posIdx = 1:numel(y)
        solution.y(freePieceIdx) = y(posIdx);
        solution.x(freePieceIdx) = x(posIdx);

        % Test placement
        [result,newBoardData] = testSolution(solution,solution.board,pieces);
        if result
            newRemainingPieceIDs = remainingPieceIDs(remainingPieceIDs ~= ID);
            if ~isempty(newRemainingPieceIDs)
                newSolutionSet = recurse(solution,pieces,newBoardData,newRemainingPieceIDs,newPerimeterIdx);
            else
                newSolutionSet.id = solution.id;
                newSolutionSet.x = solution.x;
                newSolutionSet.y = solution.y;
            end

            for j = 1:numel(newSolutionSet)
                if isUniqueSolution(solutionSet,newSolutionSet(j))
                    solutionIdx = solutionIdx + 1;
                    solutionSet(solutionIdx) = newSolutionSet(j);
                end
            end
        end
    end
end
end
