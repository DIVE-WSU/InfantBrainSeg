% function produce_batch(root_dir, num_batches, save_dir)
% function produce_batch(root_dir, num_batches, save_dir)


clc;
clear all;


root_dir = 'Z:\Fly_image\stage_resize_bmp';  
num_batches = 6;
save_dir = 'Z:\Fly_image\stage_resize_bmp_new';

a = dir(root_dir);
addpath(genpath(root_dir));
for i = 3 : size(a,1);
	folder_name{i-2, 1} = a(i,1).name; %  stage10, stage11, ...
end


 for i  =  1 : size(folder_name,1) % 15 
     
 	dir_1 = strcat(root_dir,'\', folder_name(i,1),'/*.bmp');
	b = dir(char(dir_1));
    num_bmps(i) = size(b,1) - 2; % 250, 274, 260, ...
	for j = 3 : size(b,1) 
		name_1{i, j-2 } = b(j,1).name;
	end
 end


num_bmps_per_batch = floor(num_bmps/num_batches); % 250/6

mkdir(save_dir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k = 1 : num_batches 
    k
   batch_folder = strcat(save_dir, '\', num2str(k)); 
   mkdir(batch_folder)
   
   batch_label = [];
   
   for i = 1 : size(name_1,1) % 1 : 15
        i;
        rand('seed', k * 1000 + i)
      idx = randsample( num_bmps(i), num_bmps_per_batch(i));
       for j = 1 :  length(idx) 
          j;
          name_temp{j} = name_1{i, idx(j)};
          file_source = char( strcat(root_dir, '\', folder_name(i), '\', name_temp{j}));
%           copyfile( file_source, batch_folder );
      
      end
      
      idx_left = setdiff( 1 : num_bmps(i), idx);
      clear temp_1
      temp_1 = cell(1, length(idx_left));
      
      for j = 1 : length(idx_left)
         temp_1{j} = name_1{i, idx_left(j)};
      end
       batch_label = [batch_label  i * ones(1,length(idx))];
       
      temp_2 = cell(1, size(name_1,2) - length(idx_left));
      name_1(i, :) = cat(2, temp_1, temp_2); 
      num_bmps(i) = length(idx_left);      
      
   end
   cd(batch_folder)
    dlmwrite('label_input.txt', batch_label );
%    save('label_input.txt', 'batch_label', '-ascii' );
end 

 
  