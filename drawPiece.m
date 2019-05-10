function drawPiece(piece,varargin)
%Plot a piece, as defined in setupPieces in the optionally defined varargin
% TODO: define varargin properties

dx = 0;
dy = 0;
rot = 1;
if nargin < 2
    figure()
    setupFigure()
else
    for i = 2:2:numel(varargin)
        if strcmp(varargin{i-1},'fid')
            assert(isnumeric(varargin{i}) && ...
                fix(varargin{i}) == varargin{i} && varargin{i} > 0)
            figure(varargin{i})
            setupFigure();
        elseif strcmp(varargin{i-1},'axes')
            assert(isa(varargin{i},'matlab.graphics.axis.Axes'))
            axes(varargin{i})
        elseif strcmp(varargin{i-1},'dx')
            assert(isnumeric(varargin{i}))
            dx = varargin{i};
        elseif strcmp(varargin{i-1},'dy')
            assert(isnumeric(varargin{i}))
            dy = varargin{i};
        elseif strcmp(varargin{i-1},'rot')
            assert(isnumeric(varargin{i}))
            rot = varargin{i};
        else
           error('Invalid input no. %i',i-1);
        end
    end
end

for b = 1:piece.blocks
    x = piece.xData{rot}(b);
    y = piece.yData{rot}(b);
    if mod(x + y, 2) ~= piece.corner{rot}
        color = [0.44 0.68 0.18];
    else
        color = [1 1 1];
    end
    patch(dx + x + [0 1 1 0],- dy - y - [0 0 1 1 ],color,'EdgeColor',[0 0 0])

    % Outside edges %
    if x == 1 || piece.shape{rot}(y,x-1) == 0
        plot(dx + [x x],- dy - y - [0 1],'Color',[0 0 0],'LineWidth',3)
    end
    if x == piece.size{rot}(2) || piece.shape{rot}(y,x+1) == 0
        plot(dx + [x x] + 1,- dy - y - [0 1],'Color',[0 0 0],'LineWidth',3)
    end
    if y == 1 || piece.shape{rot}(y-1,x) == 0
        plot(dx + x + [0 1],- dy -[y y],'Color',[0 0 0],'LineWidth',3)
    end
    if y == piece.size{rot}(1) || piece.shape{rot}(y+1,x) == 0
        plot(dx + x + [0 1],- dy -[y y] - 1,'Color',[0 0 0],'LineWidth',3)
    end
end
end

function setupFigure()
    clf
    daspect([1 1 1])
    set(gca,'Visible','off')
    hold on
end