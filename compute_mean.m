function comput_mean(dir_root, dir_save )

% clc;
% clear all;


% dir_root = 'Z:\Fly_image\stage_resize';
a = dir(dir_root);
for i = 3 : size(a,1);
	stage_name{i-2, 1} = a(i,1).name;
end

dmatrix = [];
label = [];

for i = 1 : size(stage_name,1)
    
    data_path = char(strcat(dir_root, '\',stage_name{i, 1})); 
    files = dir([data_path,'/*.mat']);
    length(files) 
 
    for j = 1 : length(files)
        j
        [~, name_folder, ~] = fileparts(files(j).name);
    
        file_name_load = strcat([data_path,'\',name_folder, '.mat']);
        temp = load(file_name_load);
        clear idx;
        field_temp = fieldnames(temp);
        idx = temp.(field_temp{1}); 
        idx = reshape(idx, [1 prod(size(idx))]);
        dmatrix = [dmatrix; idx];
    end
end

dmatrix = double(dmatrix);
data_mean = mean(dmatrix);
data_mean = data_mean';
% data_mean = single(data_mean);

cd(dir_save);
save('data_mean.mat','data_mean');



 

