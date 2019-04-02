%% Function that verify if the person in 'path' correct to the 'identity'
% Input: image path, identity
% Output: 
%   'Same' if same person (cmp = 1), 'Different' if two picture of different people (cmp=0)
%   'Person not in database' (cmp = -1)

function cmp = verify(path, identity,database,net)

% I = imread(path);
check = 1;
%% Forward Propergation of image in given "net"
feature1 = encoding(path,net);
%% Find index of given identity in database
idx = findidx(database,identity);
%% If there is a person with 'identity' 
% we compute distance between encoded image and encoded in database
if idx~=-1
    dist = norm(feature1 - database{idx,2})/100;
else
    check = 0;
    cmp = -1;
    disp('Person not in database');
end
if check == 1
    if dist < 0.3
        cmp = 1;
%         disp('Same')
    else
        cmp = 0;
%         disp('Different')
    end
end
end
