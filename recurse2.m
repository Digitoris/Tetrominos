function solutionSet = recurse2(solution,pieces,boardData,remainingPieceIDs,perimeterIdx,excludedIDs)
%% Compose perimeter
for newPerimeterIdx = perimeterIdx:numel(solution.id)
    perimeter = getPerimeter(boardData,solution,pieces,newPerimeterIdx);
    if ~isempty(perimeter.y)
        break
    elseif newPerimeterIdx == numel(solution.id)
        error("Something went wrong, no pieces left for perimeter check")
    end
end
if newPerimeterIdx ~= perimeterIdx
%     fprintf('%i: Switched Perimeter from %i to %i\n',z,solution.id(perimeterIdx),solution.id(newPerimeterIdx));
    excludedIDs = [];
end
perimeterProfiles = createProfiles(boardData,perimeter,solution.board,true);

%% Actual recursion
solutionSet = struct('id',{},'x',{},'y',{});
solutionIdx = 0;
freePieceIdx = numel(solution.id)+1;
newExcludedIDs = excludedIDs;
for ID = remainingPieceIDs
    if all(ID ~= excludedIDs)
        solution.id(freePieceIdx) = ID;
        [y,x] = matchProfile(perimeterProfiles,pieces(ID));
        for posIdx = 1:numel(y)
%             fprintf("%i: pid: %i Testing %i | ",z,solution.id(newPerimeterIdx),ID);
            solution.y(freePieceIdx) = y(posIdx);
            solution.x(freePieceIdx) = x(posIdx);

            % Test placement
            [result,newBoardData] = testSolution(solution,solution.board,pieces);
            if result
%                 fprintf('Succes\n')
                newRemainingPieceIDs = remainingPieceIDs(remainingPieceIDs ~= ID);
                if ~isempty(newRemainingPieceIDs)
                    newSolutionSet = recurse2(solution,pieces,newBoardData,newRemainingPieceIDs,newPerimeterIdx,newExcludedIDs);
                else
                    newSolutionSet.id = solution.id;
                    newSolutionSet.x = solution.x;
                    newSolutionSet.y = solution.y;
                end

                for j = 1:numel(newSolutionSet)
                    solutionIdx = solutionIdx + 1;
                    solutionSet(solutionIdx) = newSolutionSet(j);
%                     fprintf('  Stored solution: %i\n',solutionIdx)
                end
            else
%                 fprintf('Fail\n')
            end
        end
        if isempty(y)
%             fprintf('%i: pid: %i No match for ID: %i\n',z,solution.id(newPerimeterIdx),ID)
        end
        newExcludedIDs(end+1) = ID;
    else
%         fprintf('%i: pid: %i Skipped ID: %i\n',z,solution.id(newPerimeterIdx),ID)
    end
end
end
