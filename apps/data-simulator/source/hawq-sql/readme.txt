************************************************************************ 
Pre-steps
- Go to the home directory and locate .bash_profile file.  If this file is not visible then run the following from the command line:
		defaults write com.apple.finder AppleShowAllFiles TRUE
		killall Finder
- Open the .bash_profile file located in your home directory and add the following:
		export PATH=/usr/local/bin:$PATH:/usr/local/mysql/bin
- You will need to restart your Terminal sessions to take the effect.
************************************************************************ 

************************** 
Step 1 - Setup DB 
************************** 
Import all scripts in the "dml/init" folder into Hawq

************************** 
Step 2 - Attributes 
************************** 
Run the "run_sim1_attributes.sh" script in folder "dml" to simulate service point and meter attributes

Run the appropriate "Output" script based on whether you want to output to file or the staging table

************************** 
Step 3 - Usage 
************************** 
Run the "run_sim2_usage.sh" script in folder "dml" to simulate usage

Run the appropriate "Output" script based on whether you want to output to file or the staging table

************************** 
Step 4 - Alerts 
************************** 
Run the "run_sim3_alerts.sh" script in folder "dml" to simulate alerts

Run the appropriate "Output" script based on whether you want to output to file or the staging table