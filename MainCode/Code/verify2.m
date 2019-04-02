%% Check if 2 112x96 image is the same person
% Input: 2 image and 2 id
%        net 
% Output: Correct or Incorrect

function cmp = verify2(path1,id1,path2,id2,net)
%% Forward Propergationn 2 image in 2 path to get 2 feature matrices
feature1 = encoding(path1,net);
feature2 = encoding(path2,net);
%% Compute distance between 2 feature
dist = norm(feature1 - feature2)/100;
%% Return True if having same id and distance between 2 image < 0.4
if id1==id2 
    if dist<0.4
        cmp = 1;
        disp('SAME');
    else
        cmp = 0;
        disp('Diffferent');
    end
else
    cmp = -1;
    disp('Different');

end