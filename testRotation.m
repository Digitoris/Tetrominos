p(1).xData = [1 1 1 2 2 2]-1;
p(1).yData = [1 2 3 1 2 3]-1;
p(1).blocks = 6;
p(1).size = [3 2];
p(2) = p(1);
p(3) = p(1);
p(4) = p(1);

% 90 ccw
p(2).yData = -p(1).xData + p(1).size(2) - 1;
p(2).xData = p.yData;

% 90 cw
p(3).yData = p(1).xData;
p(3).xData = -p(1).yData + p(1).size(1) -1;

% 180
p(4).yData = -p(1).yData + p(1).size(1) - 1;
p(4).xData = -p(1).xData + p(1).size(2) - 1;
