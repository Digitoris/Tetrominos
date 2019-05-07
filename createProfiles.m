function profiles = createProfiles(boardData,coords,board,sorted)
n = numel(coords.y);
profiles = struct('color',cell(1,n),'constraints',false(4,1),'x',[],'y',[]);

for i = 1:n
    profiles(i).color = mod(board.corner + coords.y(i) + coords.x(i),2);
    profiles(i).y = coords.y(i) - 1;
    profiles(i).x = coords.x(i) - 1;
    profiles(i).constraints(1) = coords.y(i) == 1 || boardData(coords.y(i)-1,coords.x(i)) ~= 0;
    profiles(i).constraints(2) = coords.y(i) == board.size(1) || boardData(coords.y(i)+1,coords.x(i)) ~= 0;
    profiles(i).constraints(3) = coords.x(i) == 1 || boardData(coords.y(i),coords.x(i)-1) ~= 0;
    profiles(i).constraints(4) = coords.x(i) == board.size(2) || boardData(coords.y(i),coords.x(i)+1) ~= 0;
end
if sorted
    total = zeros(n,1);
    for i = 1:n
        total(i) = sum(profiles(i).constraints);
    end
    [~,i] = sort(total,'descend');
    profiles = profiles(i);
end
end