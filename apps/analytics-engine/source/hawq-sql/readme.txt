***********************************************  
Step 1 (first time building a Pivotal VM only)
*********************************************** 

Add a mount folder to the Pivotal VM with the following name: grid_mount

Run in Pivotal VM: "import_folder_setup.sh" script to create the proper folder structure for data loading

***********************************************  
Step 2 - Build data model 
*********************************************** 

Run in Pivotal VM: "build-xray-db.sh" script under the "init" folder to build the database tables 

***********************************************  
Step 3 - Load data from utility  
*********************************************** 
Run in Pivotal VM: "data_loader.sh" script to load the utility's data 

***********************************************  
Step 4 - Perform calculations  
*********************************************** 
Run in Pivotal VM: "load.sh" script under the "dml" folder to load data from external tables
Run in Pivotal VM: "calculate.sh" script under the "dml" folder to create calculations 
Run in Pivotal VM: "condition-detect.sh" script under the "dml" folder to detect conditions
Run in Pivotal VM: "correlate-condition.sh" script under the "dml" folder to correlate the conditions to one another


(to refresh the entire model run the "destroy-xray-db.sh" in the "init" folder)