function  Step3_produce_ten_fold_partition_for_cnn( ratio_sampling, filter_size, num_hidden_layers)

%%% data rotation:  9 for train, 1 for test %%%

% ratio_sampling =  1;
% filter_size = 5;
% num_hidden_layers = 2;
%  
load([ 'Z:\infant\data_3_20\patch_pool_all_subjects_', num2str(ratio_sampling),'_',...
        num2str(filter_size),'_',num2str(num_hidden_layers),'.mat']);
    
for i = 1 : 10
   i 
   dir_save  = ['Z:\infant\data_3_20\', num2str(i)]; 
   if (exist(dir_save ) ==0)
       mkdir(dir_save);
   end
   temp = interval_each_subject(i,:);
   input_for_test = patch_pool(temp(1):temp(2), :,:,:);
   label_true_for_test = label_pool(temp(1):temp(2), :,:,:);
        
   input_for_train = [ patch_pool(1 : temp(1)-1, :,:,:);...
                       patch_pool(temp(2)+1 : end, :,:,:)]; 
   label_true_for_train = [ label_pool(1 : temp(1)-1, :,:,:);...
                              label_pool(temp(2)+1 : end, :,:,:)];   
   save([dir_save,'\data_for_cnn_', num2str(ratio_sampling),'_',...
        num2str(filter_size),'_',num2str(num_hidden_layers),'.mat'],...
        'input_for_test','label_true_for_test','input_for_train','label_true_for_train');                       
    size(input_for_train,1)
    size(input_for_test,1)
end
