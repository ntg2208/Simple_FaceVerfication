% Compare 2 face image
% Input: 2 face picture
% Ouput: cmp = 1 if the same, cmp = 0  if different

function res = cmp(I1,I2)

%% Load Pretrained model
model   = './model/face_deploy.prototxt';
weights = './model/face_model.caffemodel';

net     = caffe.Net(model, weights, 'test');
%%
feature1 = encoding2(I1,net);
feature2 = encoding2(I2,net);

dist = norm(feature1-feature2)/100;
if dist <0.3
    res = 1;
else
    res = 0;
end
end
