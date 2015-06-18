# GettingandCleaningData
Getting and Cleaning Data Course Project
=================================================
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  
* The site where the data was obtained:  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      
The data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* The run_analysis.R script performs the following steps to clean the data:   
 1. Read the features.txt file from the "UCI HAR Dataset" folder and store the data in a variable called *features*. 
 2. Read the activity_labels.txt file from the "UCI HAR Dataset" folder and store the data in a variable called *activity_label*.  
 3. Read X_train.txt, y_train.txt and subject_train.txt from the "UCI HAR Dataset//train" folder and store them in *X_train*, *y_train* and *subject_train* variables respectively.       
 4. Read X_test.txt, y_test.txt and subject_test.txt from the "UCI HAR Dataset//test" folder and store them in *X_test*, *y_test* and *subject_test* variables respectively.  
 5. Concatenate *X_train* to *X_test* to generate a 10299x561 data frame, *X*; concatenate *y_train* to *y_test* to generate a 10299x1 data frame, *Y*; concatenate *subject_test* to *subject_train* to generate a 10299x1 data frame, *Subject*.  
 6. Clean the column names of the subset. We remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.   
 6. We extract the measurements on the mean and standard deviation. This results in a 66 indices list. We get a subset of *X* with the 66 corresponding columns.  
 7. Combine the *Y*, *Subject* and *select_X* by column to get a new cleaned 10299x68 data frame, *cleaned_data*. Properly name the first two columns, "Activity" and "SubjectID".
 8. Write the *cleaned_data* out to "cleaned_data.txt" file in current working directory.  
 9. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. We have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, we calculate the mean of each measurement with the corresponding combination. So, after initializing the *cleaned_data* data frame and performing the two for-loops, we get a 180x68 data frame.
 12. Write the *tidy* out to "tidy_data.txt" file in current working directory. 
