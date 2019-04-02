% NOT WORKING
% Input: path to image, net
% Output: predict who it is
%


function name = whoitis(path1, net,database)

facedetect(path1);

[pathfile, namefile, ~] = fileparts(path1);
pathfile = fullfile(pathfile,[namefile '-112x96.jpg']);
%%
% I = imread(pathfile);
feature = encoding(pathfile,net);
% database = load(result/database.mat);
%%
min = 1;
idx = 0;
for i = 1:length(database)
    dist = norm(feature - database{i,2})/100;
    if dist < min
        min = dist;
        idx = i;
    end
end

if idx==0
    name = "N/A";
else
    name = database{idx,1};
end
dist
min
idx
end