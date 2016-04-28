clc;
clear all;
dir_root = 'Z:\Fly_image\bdgp_stages\stages';
a = dir(dir_root);
for i = 3 : size(a,1);
	name{i-2, 1} = a(i,1).name;
end

for i  =  1 : size(name,1)
 	dir_1 = strcat(dir_root,'\', name(i,1));
	b = dir(char(dir_1));
	for j = 3 : size(b,1);
		name_1{i, j-2 } = b(j,1).name;
	end
end

dir_root_dmatrix = 'Z:\Fly_image\bdgp_stages\stage_gray_resize_png_128';
mkdir(dir_root_dmatrix);
 
 for i = 1 : size(name_1,1)
 
    for j = 2 : size(name_1,2)
 
        j
		dir_2 = name_1(i,j);
		temp = dir_2{1,1};
		if (isempty(temp) == 0)
			dir_1 = strcat(dir_root,'\', name(i,1)) ;
            dir_to_save =char(strcat(dir_root_dmatrix,'\', name(i,1)));
            mkdir(dir_to_save);
			files = temp;
            for k = 1: size(files,1)
                k
                
                name_2 = strtok(temp,'.');
                aa = [dir_root, '\',name{i, 1},'\',temp]; 
                I = imread(aa);
                I2 = rgb2gray(I);
                J = imresize(I2,[128 128]);
                path_to_save = char (strcat(dir_to_save,'\', name_2, '.mat')); 
                %imwrite(J,path_to_save,'png');
                %imwrite(J,path_to_save,'bmp');
                save(path_to_save, 'J');
                clear path_to_save J I 
			end
		end
	end
end
