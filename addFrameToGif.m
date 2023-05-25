% function addFrameToGif(filename, frameIndex, dt)
%
% Adds a frame to an animated gif.
%
% --- Input ---
% 1. "filename"   - Name of the gif-file.
% 2. "frameindex" - Index of the frame, where frame 1 is the first frame.
% 3. "dt"         - Time between frame during playback.
% 
% By Thomas Jonsson, 2023
%
function addFrameToGif(filename, frameIndex, dt)

drawnow
frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);
if frameIndex == 1
  imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime',dt);
else
  imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime',dt);
end
