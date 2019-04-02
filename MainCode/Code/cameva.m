% Capture 2 picture, matching them whether they are the same

clc;
clear all;

%% Add path
matCaffe       = '../../caffe';
pdollarToolbox = '../../toolbox-master';
MTCNN          = '../../MTCNNv1';
addpath(genpath(matCaffe));
addpath(genpath(pdollarToolbox));
addpath(genpath(MTCNN));

%% caffe settings
caffe.set_mode_cpu();
caffe.reset_all();

%% Load Pretrained model
model   = './model/face_deploy.prototxt';
weights = './model/face_model.caffemodel';

net     = caffe.Net(model, weights, 'test');

%%
cam = webcam;

cam.Resolution = '640x480';

preview(cam);

disp('Press any key to Capture Pic1.....');

pause;

I1 = takepicture(cam);

imshow(I1);

I1s = facedetect2(I1);

% imshow(I1s);

feature1 = encoding2(I1s,net);
disp('Press any key to Capture Pic2.....');

pause;
I2 = takepicture(cam);

imshow(I2);

I2s = facedetect2(I2);

% imshow(I2s);

feature2 = encoding2(I2s,net);

dist = norm(feature1-feature2)/100;

if dist<0.4
    disp('Same');
else
    disp('Different');
end

closePreview(cam)
clear('cam');

subplot(2,2,1); imshow(I1);
subplot(2,2,2); imshow(I1s);

subplot(2,2,3); imshow(I2);
subplot(2,2,4); imshow(I2s);

