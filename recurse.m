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
%clear('perimeter','perimeterIdx')
%% Actual recursion
solutionSet = struct('id',{},'x',{},'y',{});
solutionIdx = 0;
freePieceIdx = numel(solution.id)+1;
for ID = remainingPieceIDs
    fprintf('Testing piece %i\n',ID);
    solution.id(freePieceIdx) = ID;
    [y,x] = matchProfile(perimeterProfiles,pieces(ID));
    for posIdx = 1:numel(y)
        fprintf('  at position %i,%i | ',y(posIdx),x(posIdx));
        solution.y(freePieceIdx) = y(posIdx);
        solution.x(freePieceIdx) = x(posIdx);

        % Test placement
        [result,newBoardData] = testSolution(solution,solution.board,pieces);
        if result
            fprintf('succesfully placed\n');
            newRemainingPieceIDs = remainingPieceIDs(remainingPieceIDs ~= ID);
            if ~isempty(newRemainingPieceIDs)
                newSolutionSet = recurse(solution,pieces,newBoardData,newRemainingPieceIDs,newPerimeterIdx);
            else
                newSolutionSet.id = solution.id;
                newSolutionSet.x = solution.x;
                newSolutionSet.y = solution.y;
            end

            for j = 1:numel(newSolutionSet)
                solutionIdx = solutionIdx + 1;
                solutionSet(solutionIdx) = newSolutionSet(j);
            end
        else
            fprintf('placement failed\n');
        end
    end
end
end
