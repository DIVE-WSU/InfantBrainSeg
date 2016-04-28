function  Step2_produce_patch_pool( ratio_sampling, filter_size, num_hidden_layers)

dir_load = 'Z:\infant\data_3_20';
% dir_load = 'Z:\public_html\infant';
dir_save = 'Z:\infant\data_3_20'; 
% dir_save = 'Z:\public_html\infant';
% ratio_sampling =  1;
% filter_size = 5;
% num_hidden_layers = 2;


patch_pool = [];
label_pool = [];

file_all = { 'sub1_s123',...
             'sub2_s113',...
             'sub3_s130',...
             'sub4_s125',...
             'sub5_s119',...
             'sub6_s122',...
             'sub7_s122',...
             'sub8_s126',...
             'sub9_s117',...
             'sub10_s124'};
         
         
    j = 1
    filename = char(file_all(j));
    load( [ dir_load,'\', filename, '_', num2str(ratio_sampling),'_',...
            num2str(filter_size),'_',num2str(num_hidden_layers),'.mat']);
%    load( [ dir_load,'\', filename, '.mat']);
    patch_pool = [patch_pool; patch_total_in_use];
    label_pool = [label_pool; label_total_in_use];
    
    interval_each_subject(1,:) = [1, size(label_total_in_use,1)];  % Different

for j = 2 : length(file_all)
    j
    filename = char(file_all(j));
%     load( [ dir_load,'\', filename,'.mat']);
    load( [ dir_load,'\', filename, '_', num2str(ratio_sampling),'_',...
            num2str(filter_size),'_',num2str(num_hidden_layers),'.mat']);
    patch_pool = [patch_pool; patch_total_in_use];
    label_pool = [label_pool; label_total_in_use];
    interval_each_subject(j,:) = [interval_each_subject(j-1,2)+1, interval_each_subject(j-1,2)+size(label_total_in_use,1)];
end

save([ dir_save,'\patch_pool_all_subjects_', num2str(ratio_sampling),'_',...
        num2str(filter_size),'_',num2str(num_hidden_layers),'.mat'],...
        'patch_pool', 'label_pool','interval_each_subject');
