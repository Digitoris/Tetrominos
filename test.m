s.id = solution.id;
s.x = solution.x;
s.y = solution.y;
s.board = solution.board;
p = setupPieces();

r = 2:14;
s.id(r) = [];
s.x(r) = [];
s.y(r) = [];

[~,b] = testSolution(s,s.board,p);
sol2 = recurse2(s,p,b,r,1,[],1);
