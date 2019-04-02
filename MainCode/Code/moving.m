%%
% move image in list 1 to newpath (image 1 to database, image 7 to test)


clear all;
clc;

list1 = 'C:\Users\Admin\Desktop\FaceVerification\Train\database.txt';
list2 = 'C:\Users\Admin\Desktop\FaceVerification\Train\ImageIn.txt';

datapath = 'C:\Users\Admin\Desktop\FaceVerification\Train\vggface2_test\test';
newpath1 = 'C:\Users\Admin\Desktop\FaceVerification\TestingSpace\Image\data';
newpath2 = 'C:\Users\Admin\Desktop\FaceVerification\TestingSpace\Image\ImIn';
%% Data moving
datalist1 = importdata(list1);
for i = 1:length(datalist1)
    s = strcat(datapath,'\',datalist1{i});

    s = strrep(s,'/','\');

    I = imread(s);

    [npath, file, ~] = fileparts(s);

    newpath = strrep(npath,datapath,newpath1);
    if ~exist(newpath, 'dir')
        mkdir(newpath)
    end

    imwrite(I,fullfile(newpath,[file,'.jpg']),'jpg');
end
%% Image In moving
datalist2 = importdata(list2);

for i = 1:length(datalist2)
    s = strcat(datapath,'\',datalist2{i});

    s = strrep(s,'/','\');

    I = imread(s);

    [npath, file, ~] = fileparts(s);

    newpath = strrep(npath,datapath,newpath2);
    if ~exist(newpath, 'dir')
        mkdir(newpath)
    end

    imwrite(I,fullfile(newpath,[file,'.jpg']),'jpg');
end

