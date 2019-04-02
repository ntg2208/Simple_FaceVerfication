%% Extract deep feature of image 512x1 -> 1024x1
% Encode the given image into 1024x1 matrix feature
% Input: file: 112x96 face detected and alliged
% Output: 1024x1 matrix feature.
function feature = encoding2(file, net)
%     img     = single(imread(file)); %if file is path
    img     = single(file);
    img     = (img - 127.5)/128;
    img     = permute(img, [2,1,3]);
    img     = img(:,:,[3,2,1]);
    res     = net.forward({img});
    res_    = net.forward({flip(img, 1)});
    feature = double([res{1}; res_{1}]);
end