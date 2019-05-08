function solutionSet = recurse(solution,pieces,boardData,remainingPieceIDs,perimeterIdx)
%% Compose perimeter
for newPerimeterIdx = perimeterIdx:numel(solution.id)
    perimeter = getPerimeter(boardData,solution,newPerimeterIdx);
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
for profile = perimeterProfiles
    for ID = remainingPieceIDs
        [dy,dx] = matchProfile(profile,pieces(ID));
        % Quickfilter pieces based on perimeter block fit
        if isempty(dy)
            continue
        else
            % Place block and do full analysis
            solution.id(freePieceIdx) = ID;
            solution.y(freePieceIdx) = profile.y - dy;
            solution.x(freePieceIdx) = profile.x - dx;
            
            % Test placement
            [result,newBoardData] = testSolution(solution);
            if result
                newRemainingPieceIDs = remainingPieceIDs(remainingPieceIDs ~= ID);
                newSolutionSet = recurse(solution,pieces,newBoardData,newRemainingPieceIDs,newPerimeterIdx);
                
                for j = 1:numel(solutionSet)
                    solutionIdx = solutionIdx + 1;
                    solutionSet(solutionIdx) = newSolutionSet(j);
                end
            end
        end
    end
end
end
