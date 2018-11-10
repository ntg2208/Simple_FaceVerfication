%% Find the index corressponding to given id
% Input: database of student with [id encoded]
%		 id of student need to find encoded
% Output: index of given id in database
function idx = findidx(database,id)
    idx = -1;
    for i = 1:size(database,1)
        if database{i,1}==id
            idx = i;
        end   
    end
end