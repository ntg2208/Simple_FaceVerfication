%% Count how many right and wrong in the set of 20 30 40

function accur = eva()

total = 40;
right = 0;


% load result/val.mat val;
% load result/database.mat database;
load result/dataList dataList;
% dataList(1).name
for i = 1:total
%     idx = findidx(database,val{i,1});
%     if (idx~=-1)
%         feature1 = database{idx,2};
%         feature2 = val{i,2};
%         dist = norm(feature1 - feature2)/100;
%         if dist < 0.395
%             right = right +1;
%         end
%     end
    num = studentID(imread(dataList(i).file));
    if num==str2num(dataList(i).name)
        right = right + 1;
%     else
%         num
    end
end
right
accur = right*100/total;
end