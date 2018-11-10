%% Read in 2 image: Detect if 2 face is the same person

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

%% Preprocess data
% Load image into I1, I2, I3
path1 = '.\Image\test2.jpg'; %1551034
path2 = '.\Image\test4.jpg'; %1550134
path3 = '.\Image\test3.jpg'; %1551031

I1 = imread(path1);
I2 = imread(path2);
I3 = imread(path3);
%% Detect student id in 3 given Student ID card
id1 = studentID(I1);
id2 = studentID(I2);
id3 = studentID(I3);
%% Detect face of picture in "path" then export to "name-112x96.jpg"
facedetect(path1);
facedetect(path2);
facedetect(path3);
%% Load Pretrained model
model   = './model/face_deploy.prototxt';
weights = './model/face_model.caffemodel';

net     = caffe.Net(model, weights, 'test');
%% Verify
% 112x96 Image after detect face
path1 = '.\Image\test2-112x96.jpg'; %1551034
path2 = '.\Image\test4-112x96.jpg'; %1550134
path3 = '.\Image\test3-112x96.jpg'; %1551031

cmp1 = verify2(path1,id1,path2,id2,net)
% cmp2 = verify2(path1,id1,path3,id3,net)