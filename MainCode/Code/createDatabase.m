%%Create database.mat in ./result
% Database is a cell with 2 column 'id' and '1024x1 encode'
% Input: NN use to extract feature
% Output: database.mat in ./result
function createDatabase(net)
clc;
fprintf('Creating database ......\n');
load result/dataList.mat
c = 0;
%% Encode every image from dataList.file
for i = 1:length(dataList)
    if (dataList(i).dataset == "Database")
        database(i).id = dataList(i).name;
        impath = strrep(dataList(i).file,'\Database\','\Database-112x96\');
        database(i).encode = encoding(impath,net);
    elseif (dataList(i).dataset == "val")
        c = c + 1;
        val(c).id = dataList(i).name;
        impath = strrep(dataList(i).file,'\val\','\val-112x96\');
        val(c).encode = encoding(impath,net);
    end
        
end
%% Change database into cell then save it in ./result
database = struct2cell(database')';
val = struct2cell(val')';
fprintf("Done\n");
save result/database.mat database
save result/val.mat val
end