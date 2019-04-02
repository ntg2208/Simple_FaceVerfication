% Pre-process (detect and alligned), creat database given 1 picture of student
% Input: file, net
% Output: 2 folder with detected face in Test1 and Data

function preprocess()
clear;clc;close all;
% cd('../');
face_detect()
face_align()

end

function face_detect()
% Detect face on 2 given picture using MTCNN
% Input: list of picture
% Output: dataList.mat in /result
%% mtcnn settings
minSize   = 20;
factor    = 0.85;
threshold = [0.6 0.7 0.9];
%% collect a image list
trainList = collectData('C:\Users\Admin\Desktop\FaceVerification\mydata\Database','Database');%collectData(fullfile(pwd, 'data/Data'), 'Data');
testList  = collectData('C:\Users\Admin\Desktop\FaceVerification\mydata\val','val');%collectData(fullfile(pwd, 'data/Test1'), 'Test1');
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

modelPath = '../../MTCNNv1/model';
PNet = caffe.Net(fullfile(modelPath, 'det1.prototxt'), ...
                 fullfile(modelPath, 'det1.caffemodel'), 'test');
RNet = caffe.Net(fullfile(modelPath, 'det2.prototxt'), ...
                 fullfile(modelPath, 'det2.caffemodel'), 'test');
ONet = caffe.Net(fullfile(modelPath, 'det3.prototxt'), ...
                 fullfile(modelPath, 'det3.caffemodel'), 'test');
%% face and facial landmark detection
dataList = [trainList; testList];
for i = 1:length(dataList)
    fprintf('detecting the %dth image...\n', i);
    % load image
    img = imread(dataList(i).file);
    if size(img, 3)==1
       img = repmat(img, [1,1,3]);
    end
    % detection
    [bboxes, landmarks] = detect_face(img, minSize, PNet, RNet, ONet, threshold, false, factor);

    if size(bboxes, 1)>1
       % pick the face closed to the center
       center   = size(img) / 2;
       distance = sum(bsxfun(@minus, [mean(bboxes(:, [2, 4]), 2), ...
                                      mean(bboxes(:, [1, 3]), 2)], center(1:2)).^2, 2);
       [~, Ix]  = min(distance);
       dataList(i).facial5point = reshape(landmarks(:, Ix), [5, 2]);
    elseif size(bboxes, 1)==1
       dataList(i).facial5point = reshape(landmarks, [5, 2]);
    else
       dataList(i).facial5point = [];
    end
end
save result/dataList.mat dataList

end

function list = collectData(folder,name)
    subFolders = struct2cell(dir(folder))';
    subFolders = subFolders(3:end, 1);
    files      = cell(size(subFolders));
    for i = 1:length(subFolders)
        fprintf('%s --- Collecting the %dth folder (total %d) ...\n', name, i, length(subFolders));
        subList  = struct2cell(dir(fullfile(folder, subFolders{i}, '*.jpg')))';
        files{i} = fullfile(folder, subFolders{i}, subList(:, 1));
    end
    files      = vertcat(files{:});
    dataset    = cell(size(files));
    dataset(:) = {name};
    list       = cell2struct([files dataset subFolders], {'file', 'dataset', 'name'}, 2);
end
%% Face align read in facial 5 point above, return picture 112x96 in Data - 112x96
function face_align()

clear;clc;close all;
% cd('../');

load('result/dataList.mat');
%% alignment settings
imgSize     = [112, 96];
coord5point = [30.2946, 51.6963;
               65.5318, 51.5014;
               48.0252, 71.7366;
               33.5493, 92.3655;
               62.7299, 92.2041];

%% face alignment
for i = 1:length(dataList)
    fprintf('aligning the %dth image...\n', i);
    if isempty(dataList(i).facial5point)
       continue;
    end
    dataList(i).facial5point = double(dataList(i).facial5point);
    % load and crop image
    img      = imread(dataList(i).file);
    transf   = cp2tform(dataList(i).facial5point, coord5point, 'similarity');
    cropImg  = imtransform(img, transf, 'XData', [1 imgSize(2)],...
                                        'YData', [1 imgSize(1)], 'Size', imgSize);
    % save image
    [sPathStr, name, ~] = fileparts(dataList(i).file);
    tPathStr = strrep(sPathStr, '/data/', '/result/');
    tPathStr = strrep(tPathStr, dataList(i).dataset, [dataList(i).dataset '-112x96']);
    if ~exist(tPathStr, 'dir')
       mkdir(tPathStr)
    end
    imwrite(cropImg, fullfile(tPathStr, [name, '.jpg']), 'jpg');
end

end

