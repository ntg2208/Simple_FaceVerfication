vid = videoinput('winvideo', 1, 'YUY2_640x480');
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';

preview(vid);

pause;

I1 = getsnapshot(vid);

closepreview(vid);
stop(vid);
imshow(I1);
clear('vid')