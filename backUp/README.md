To run the code you have to enter the command:
source('run_analysis.R')

The script expects you have a diretory called "UCI HAR Dataset" with all the samsung data inside.

Script read and clean the data and write a text file called tidy5.txt in the same diretory.

The scripts merges test and traind data and select the variables that contains standar deviations and means. 
It combines with Training labels and Subject IDs too.

This file contains the average of each variable for each activity and each subject.
