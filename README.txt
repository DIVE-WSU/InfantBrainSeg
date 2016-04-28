Preprocessing Procedure:


  Build batches:
	 (a)  move .bmps from different stage folders under a batch folder 
	   ( hint : run  move_bmps.m)
	   example: 
	   
			root_dir = 'Z:\Fly_image\stage_resize_bmp';   % where you saved .bmp
			num_batches = 6;
			save_dir = 'Z:\Fly_image\stage_resize_bmp_new'; % where you want to save .bmp moved
			move_bmps(root_dir, num_batches, save_dir);
			
	 (b)  build python format batch files
		type in Terminal: 
		   % python
		   >>> from build_batch  import *
		   >>> makeBatch (load_path, save_path, label_input)
			
			load_path:  the folder name where bmps for some specific batch are saved 
			save_path:  the folder name where you want some specific batch are saved 
			label_input: the text file saving labels of each bmp file. 
		example:
			makeBatch( "/home/wzhang/Fly_image/stage_resize_bmp_new/1", "/home/wzhang/Fly_image/stage_resize_bmp_new/data_batch_1", "/home/rli/Fly_image/stage_resize_bmp_new/1/label_input.txt" )
	 (c) build python format meta files
		(c.1) you have to produce the mean vector of all sample bmps.
		  (hint : run compute_mean.m )
		
		Example :  
		   root_dir = 'Z:\Fly_image\stage_resize';
		   save_dir = 'Z:\Fly_image\stage_resize_bmp_new';
	       compute_mean(root_dir, save_dir);
		   
	 
		type in Terminal: 
		   % python
		   >>> from build_meta import *
		   >>> makeBatch( mean_input, label_name_input,  num_cases_per_batch, dimension,save_path) 

				mean_input : the mean vector produced by compute_mean.m. 
				label_name_input : the label vector of each sample image. 
				num_cases_per_batch : the number of bmps in each batch. 
				dimension : the number of each image vector, e.g. 256*256*3.
				save path : the name of the file you want to save. NOTE: it is the name of FILE directly not the FOLDER.
			
			Example: 
			makeBatch( "/home/wzhang/Fly_image/stage_resize_bmp_new/data_mean.mat", "/home/wzhang/Fly_image/label_names.txt", 612, 196608, "/home/rli/Fly_image/stage_resize_bmp_new/data.meta")
 
 
		P.S. if you want to know the content of some python format batch file:
		
		one way is to run the code look_content.py
 
		type in Terminal: 
		   % python
		   >>> from look_content import *
		   >>> unpickle(file_name)
		   
		   Example : unpickle("/home/wzhang/Fly_image/stage_resize_bmp_new/data.meta");
		   
			There is a commonly seen error for Python:  IndentationError . 
			This error means you might miss or add some white spaces. Please have a check.   
