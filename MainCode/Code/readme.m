% Useful code function in this project

%===============================================================================================
function idx = findidx(database,id)
    idx = -1;
    for i = 1:size(database,1)
        if database{i,1}==id
            idx = i;
        end   
    end
end
%%=============================================================================================
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
%%=============================================================================================
%% preprocess.m

trainList = collectData('C:\Users\Admin\Desktop\FaceVerification\mydata\Database','Database');

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

