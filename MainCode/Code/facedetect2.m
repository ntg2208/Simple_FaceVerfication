%% Detect face of people in single picture
% Input: path to image
% Output: 112x96 face align image in same directory 
% RETURN I IS THE CROPPED PICTURE


function I = facedetect2(img)
%% mtcnn settings
minSize   = 20;
factor    = 0.85;
threshold = [0.6 0.7 0.9];
%% caffe settings

% caffe.set_mode_cpu();
% caffe.reset_all();

modelPath = '../../MTCNNv1/model';
PNet = caffe.Net(fullfile(modelPath, 'det1.prototxt'), ...
    fullfile(modelPath, 'det1.caffemodel'), 'test');
RNet = caffe.Net(fullfile(modelPath, 'det2.prototxt'), ...
    fullfile(modelPath, 'det2.caffemodel'), 'test');
ONet = caffe.Net(fullfile(modelPath, 'det3.prototxt'), ...
    fullfile(modelPath, 'det3.caffemodel'), 'test');

%% Detection process
% img = imread(path);

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
    facial5point = reshape(landmarks(:, Ix), [5, 2]);
elseif size(bboxes, 1)==1
    facial5point = reshape(landmarks, [5, 2]);
else
    facial5point = [];
end

%% alignment settings
imgSize     = [112, 96];

coord5point = [30.2946, 51.6963;
                65.5318, 51.5014;
                48.0252, 71.7366;
                33.5493, 92.3655;
                62.7299, 92.2041];

facial5point = double(facial5point);
% load and crop image
transf   = cp2tform(facial5point, coord5point, 'similarity');
cropImg  = imtransform(img, transf, 'XData', [1 imgSize(2)],...
                                    'YData', [1 imgSize(1)], 'Size', imgSize);
% % save image
% [sPathStr, name, ~] = fileparts(path);
% imwrite(cropImg, fullfile(sPathStr, [name,'-112x96', '.jpg']), 'jpg');
I = cropImg;
end