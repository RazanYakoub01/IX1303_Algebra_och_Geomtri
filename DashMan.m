% function D = DashMan()
%
% Returns a representation of a drawing of a dash-man. The drawing consists
% of polygons that represents the head, mouth, body arms and legs. Each of
% the polygons are matrices where each column is a point on the polygon.
% The first row represent the horizontal coordinate, the second row the
% vertical coordinate and the third row is a homogeneous coordinate.
% 
% --- Output ---
% 1. "D" - a struct including the children head, mouth, body arms and legs.
%
% See also plotDashMan
%
% By Thomas Jonsson, 2023
%
function D = DashMan()

theta = linspace(-pi,pi,50);
headHeight = 0.25;
headWidth  = 0.15;
neck = 1-headHeight;
armsHeight = neck - 0.05;
handHeight = neck - 0.15;
armLength = 0.2;
legHeight = 0.5;
legWidth  = 0.13;

D.head = [0.5*headWidth*sin(theta)
          0.5*headHeight*cos(theta) + neck + headHeight/2
          ones(size(theta))];

D.mouth = [0.3*headWidth*sin(0.2*theta)
          -0.3*headHeight*cos(0.2*theta) + neck + headHeight/2
          ones(size(theta))];

D.body = [0   , 0
          neck, legHeight
          1   , 1];

D.legs = [0.5*legWidth, 0        , -0.5*legWidth
          0           , legHeight, 0
          1           , 1        , 1];

D.arms = [armLength  , 0          , -armLength
          handHeight , armsHeight , handHeight
          1          , 1          1];

