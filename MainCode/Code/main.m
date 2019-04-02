%% with image in given folder allign it into 112x96 then verify

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
% gpu = 1;
% if gpu
%    gpu_id = 0;
%    caffe.set_mode_gpu();
%    caffe.set_device(gpu_id);
% else
%    caffe.set_mode_cpu();
% end
caffe.set_mode_cpu();
caffe.reset_all();

%% Preprocess data
% From given folder transform the image into 112x96 image in
% 'Folder-112x96'
preprocess();

%% Load Pretrained model
model   = './model/face_deploy.prototxt';
weights = './model/face_model.caffemodel';

net     = caffe.Net(model, weights, 'test');
%% Creat database.mat in ./result
% Have 2 column [id encoded]
%       id: name of person
%       encoded: 1024x1 vector of id's face
createDatabase(net);


