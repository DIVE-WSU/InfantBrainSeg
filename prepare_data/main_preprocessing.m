clc
clear all

%%pay attention to step1 code: patch_size_half = 4(line42)
%% in this infant project, we have four steps. the first three steps is in infant folder; the last step is in cnpkg folder.
%% Parameters:

ratio_sampling =  1;
filter_size = 3;
num_hidden_layers = 2;

disp('Now working on Step1 ...');
Step1_produce_patches( ratio_sampling, filter_size, num_hidden_layers)

disp('Now working on Step2 ...');
Step2_produce_patch_pool( ratio_sampling, filter_size, num_hidden_layers)

disp('Now working on Step3 ...');
Step3_produce_ten_fold_partition_for_cnn( ratio_sampling, filter_size, num_hidden_layers)

% size(input_for_train,1)
% size(input_for_test,1)