function output = setupPieces()
pieces = struct();

pieces(1).xData = [1 1 2];
pieces(1).yData = [1 2 2];
pieces(1).corner = 0;

pieces(2).xData = [1 2 3 2];
pieces(2).yData = [1 1 1 2];
pieces(2).corner = 1;

pieces(3).xData = [1 2 2 3 3];
pieces(3).yData = [1 1 2 2 3];
pieces(3).corner = 0;

pieces(4).xData = [1 2 2 2 2];
pieces(4).yData = [1 1 2 3 4];
pieces(4).corner = 0;

pieces(5).xData = [3 1 2 3 1];
pieces(5).yData = [1 2 2 2 3];
pieces(5).corner = 0;

pieces(6).xData = [2 2 1 2 1];
pieces(6).yData = [1 2 3 3 4];
pieces(6).corner = 0;

pieces(7).xData = [1 1 1 2 2];
pieces(7).yData = [1 2 3 3 4];
pieces(7).corner = 0;

pieces(8).xData = [1 1 2 1 1];
pieces(8).yData = [1 2 2 3 4];
pieces(8).corner = 1;

pieces(9).xData = [2 2 2 1 2];
pieces(9).yData = [1 2 3 4 4];
pieces(9).corner = 0;

pieces(10).xData = [2 1 2 1];
pieces(10).yData = [1 2 2 3];
pieces(10).corner = 1;

pieces(11).xData = [2 3 2 1 2];
pieces(11).yData = [1 1 2 3 3];
pieces(11).corner = 1;

pieces(12).xData = [1 1 1 2];
pieces(12).yData = [1 2 3 3];
pieces(12).corner = 1;

pieces(13).xData = [2 2 1 2];
pieces(13).yData = [1 2 3 3];
pieces(13).corner = 1;

pieces(14).xData = [3 1 2 3 4];
pieces(14).yData = [1 2 2 2 2];
pieces(14).corner = 0;

c = cell(1,numel(pieces));
output = struct('id',c,'corner',c,'size',c,'blocks',c,'symmetry',c,'shape',c,'xData',c,'yData',c);
for i = 1:numel(pieces)
    output(i).blocks = numel(pieces(i).yData);
    output(i).id = i;
    output(i).corner = cell(4,1);
    output(i).size = cell(4,1);
    output(i).xData = cell(4,1);
    output(i).yData = cell(4,1);
    output(i).shape = cell(4,1);
    for j = 1:4
        output(i).corner{j} = boolean(pieces(i).corner);
        output(i).size{j} = [max(pieces(i).yData) max(pieces(i).xData)];
        output(i).xData{j} = pieces(i).xData;
        output(i).yData{j} = pieces(i).xData;
        output(i).shape{j} = constructShape(pieces(i));
        
        temp = pieces(i).xData;
        pieces(i).xData = -pieces(i).yData + output(i).size{j}(1) + 1;
        pieces(i).yData = temp;
        pieces(i).corner = mod(pieces(i).corner + output(i).size{j}(1) - 1,2);
    end
end
end