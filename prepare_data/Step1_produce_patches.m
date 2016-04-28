function  Step1_produce_patches( ratio_sampling, filter_size, num_hidden_layers)

dir_save  = 'Z:\infant\data_3_20'; 

if (exist(dir_save ) ==0)
	mkdir(dir_save);
end

file_all = { 'sub1_s123',...
             'sub2_s113',...
             'sub3_s130',...
             'sub4_s125',...
             'sub7_s122',...
             'sub8_s126',...
             'sub9_s117',...
             'sub10_s124'};
   
%%
for j = 1 : length(file_all)
    j
    filename = char(file_all(j));
    
    a1 = imread(['Z:\infant\6month-manual\manual\',filename,'_T1.bmp']);% each T1 image;
    gray_T1 = rgb2gray( a1); 
    a2 = imread(['Z:\infant\6month-manual\manual\',filename,'_T2.bmp']);% each T2 image;
    gray_T2 = rgb2gray( a2); 

    a3 = imread(['Z:\infant\6month-manual\manual\',filename,'_FA.bmp']);% each FA image;
    gray_FA = rgb2gray( a3); 
    

    bb = imread(['Z:\infant\6month-manual\manual\',filename,'_seg.bmp']);% each T1 image;
    gray_seg = rgb2gray(bb); 

    [x_foreground, y_foreground] = find(gray_T1>2);

    patch_size_half =floor(num_hidden_layers * (filter_size - 1)/2);
    index_GM = [];
    index_WM = [];
    index_CSF = [];
    index_useless = [];
    
    for i = 1 : length(x_foreground)
        i ;
        if (  x_foreground(i) - patch_size_half<= 0 ...
              || y_foreground(i) - patch_size_half <= 0 ...
              || x_foreground(i) + patch_size_half > size(gray_T1,1) ...
              || y_foreground(i) + patch_size_half > size(gray_T1,2)) 
            index_useless = [index_useless; i];
            continue;
        end

        patch_T1 = gray_T1( x_foreground(i) - patch_size_half : x_foreground(i) + patch_size_half,...
                              y_foreground(i) - patch_size_half : y_foreground(i) + patch_size_half);
        patch_T2 = gray_T2( x_foreground(i) - patch_size_half : x_foreground(i) + patch_size_half,...
                              y_foreground(i) - patch_size_half : y_foreground(i) + patch_size_half);
        patch_FA = gray_FA( x_foreground(i) - patch_size_half : x_foreground(i) + patch_size_half,...
                              y_foreground(i) - patch_size_half : y_foreground(i) + patch_size_half);
        
        if  ( gray_seg(x_foreground(i), y_foreground(i))>=5 &&  gray_seg(x_foreground(i), y_foreground(i))<= 15)
            label_each_patch =[1 1e-10 1e-10]; % CSF
            index_CSF = [ index_CSF ; i];
        elseif ( gray_seg(x_foreground(i), y_foreground(i))>= 140 &&  gray_seg(x_foreground(i), y_foreground(i))<= 160 )
            label_each_patch =[1e-10 1 1e-10]; % GM
            index_GM = [ index_GM ; i];
        elseif ( gray_seg(x_foreground(i), y_foreground(i))>= 240 &&  gray_seg(x_foreground(i), y_foreground(i))<=255)
            label_each_patch =[1e-10 1e-10 1]; % WM
            index_WM = [ index_WM ; i];
        else
            continue;
        end
        patch_total(i, :, :, 1) = patch_T1;
        patch_total(i, :, :, 2) = patch_T2;
        patch_total(i, :, :, 3) = patch_FA;
        label_total(i,:) = label_each_patch ;
    end
    patch_total = double( patch_total);
    
    num_CSF = length(index_CSF); %% How many patches are in CSF
    num_CSF_in_use = floor(num_CSF * ratio_sampling); %% How many patches we use
%     rand('seed', j*20 + 1);
    index_CSF_in_use = datasample(index_CSF ,  num_CSF_in_use,'Replace',false);  %%% the indices that we  will use  
    
    num_WM = length(index_WM);
    num_WM_in_use = floor(num_WM * ratio_sampling); 
%  	rand('seed', j*20 + 2);
    index_WM_in_use = datasample(index_WM ,  num_WM_in_use,'Replace',false);
    
    
    num_GM = length(index_GM);
    num_GM_in_use = floor(num_GM * ratio_sampling);
%   	rand('seed', j*20 + 3);
    index_GM_in_use = datasample(index_GM ,  num_GM_in_use,'Replace',false);

    index_patch_in_use = [  index_GM_in_use;...
                            index_WM_in_use;...
                            index_CSF_in_use];
    patch_total_in_use = patch_total(index_patch_in_use,:,:,:); 
    label_total_in_use = label_total(index_patch_in_use,:,:,:); 
    
    %% For checking the error
    temp1 = mean(patch_total_in_use,1); %% 1 * 13 * 13 * 3
    temp2 = shiftdim(temp1); %% 13 * 13 * 3
    aa = max(max(max(shiftdim(temp2))));
    
    if( aa == 0)
        error('Patch is wrong!');
    end
    
    clear temp1 temp2 aa;
    temp1 = mean(label_total_in_use,1); %% 1 * 3
    aa = max(temp1);
    
	if( aa == 0)
        error('Label is wrong!');
    end
    
    %%
    save([dir_save,'\', filename,'_', num2str(ratio_sampling),'_',num2str(filter_size),...
          '_',num2str(num_hidden_layers),'.mat'], 'patch_total_in_use', 'label_total_in_use','index_patch_in_use','x_foreground','y_foreground');
    clearvars -except dir_save file_all  filter_size  num_hidden_layers  ratio_sampling

end
    