function solutionSet = recurse(solution,pieces,board,boardData,remainingPieceIDs,perimeterIdx,excludedHashes)
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
    excludedHashes = [];
end
perimeterProfiles = createProfiles(boardData,perimeter,board,true);

%% Actual recursion
solutionSet = struct('id',{},'rot',{},'x',{},'y',{});
solutionIdx = 0;
freePieceIdx = numel(solution.id)+1;
newExcludedHashes = excludedHashes;
for ID = remainingPieceIDs
    for rot = 1:4
        hash = ID*4 + rot;
        if all(hash ~= excludedHashes)
            solution.id(freePieceIdx) = ID;
            solution.rot(freePieceIdx) = rot;
            [y,x] = matchProfile(perimeterProfiles,pieces(ID),rot);
            for posIdx = 1:numel(y)
    %             fprintf("%i: pid: %i Testing %i | ",z,solution.id(newPerimeterIdx),ID);
                solution.y(freePieceIdx) = y(posIdx);
                solution.x(freePieceIdx) = x(posIdx);

                % Test placement
                [result,newBoardData] = addPiece(boardData,pieces,solution.id(freePieceIdx),...
                    solution.rot(freePieceIdx),solution.x(freePieceIdx),solution.y(freePieceIdx));

                if result
    %                 fprintf('Succes\n')
                    newRemainingPieceIDs = remainingPieceIDs(remainingPieceIDs ~= ID);
                    if ~isempty(newRemainingPieceIDs)
                        newSolutionSet = recurse(solution,pieces,board,newBoardData,newRemainingPieceIDs,newPerimeterIdx,newExcludedHashes);
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
            newExcludedHashes(end+1) = hash;
        else
    %         fprintf('%i: pid: %i Skipped ID: %i\n',z,solution.id(newPerimeterIdx),ID)
        end
    end
end
end
