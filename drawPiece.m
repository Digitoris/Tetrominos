function drawPiece(piece,varargin)
%Plot a piece, as defined in setupPieces in the optionally defined varargin
% TODO: define varargin properties

dx = 0;
dy = 0;

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
        else
           error('Invalid input no. %i',i-1);
        end
    end
end

for x = 1:piece.size(2)
    for y = 1:piece.size(1)
        if piece.shape(y,x)
            if mod(x + y, 2) ~= piece.corner
                color = [0.44 0.68 0.18];
            else
                color = [1 1 1];
            end
            patch(dx + x + [0 1 1 0],- dy - y - [0 0 1 1 ],color,'EdgeColor',[0 0 0])
            
            % Outside edges %
            if x == 1 || piece.shape(y,x-1) == 0
                plot(dx + [x x],- dy - y - [0 1],'Color',[0 0 0],'LineWidth',3)
            end
            if x == piece.size(2) || piece.shape(y,x+1) == 0
                plot(dx + [x x] + 1,- dy - y - [0 1],'Color',[0 0 0],'LineWidth',3)
            end
            if y == 1 || piece.shape(y-1,x) == 0
                plot(dx + x + [0 1],- dy -[y y],'Color',[0 0 0],'LineWidth',3)
            end
            if y == piece.size(1) || piece.shape(y+1,x) == 0
                plot(dx + x + [0 1],- dy -[y y] - 1,'Color',[0 0 0],'LineWidth',3)
            end
            
        end
    end
end
end

function setupFigure()
    clf
    daspect([1 1 1])
    set(gca,'Visible','off')
    hold on
end