function ax = drawSolution(solution,pieces)
figure()
daspect([1 1 1])
set(gca, 'Visible', 'off')
hold on

ax = gca;

if any(size(solution.id) ~= size(solution.x)) || any(size(solution.id) ~= size(solution.y))
    error('Invalid solution (dim size)')
end

for i = 1:numel(solution.id)
    drawPiece(pieces(solution.id(i)),'axes',ax,...
        'dx',solution.x(i),'dy',solution.y(i));
end
end