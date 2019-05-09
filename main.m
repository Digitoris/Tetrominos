board.size = [8 8];
pieces = setupPieces();
solutions = findSolution(pieces,board);

for i = 1:numel(solutions)
   for j = 1:numel(solutions(i).set)
       drawSolution(solutions(i).set(j),pieces)
   end
end