## Description of run_analysis.R script
Prerequisites for script:
Samsung data should be available in the working directory in an unzipped folder "UCI HAR Dataset".

The goal of this script is to complete following 5 steps of course project:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
 
 
 Here's how it's achieved in run_analysis.R (Note: steps are not completed in this exact order).
 
 Script loads datasets from train and test folders to local variables ("Inertial signals" folders data is not included)
 Using names() function set names of test and train data tables.
 
 Using cbind function merge together subjects, data and activity for test. Same is done for train data.
 Using rbind function merge together test and train data tables. This completes step 1 from the list.
 
 Following step is to convert "activity" column to factor and set levels for that factor accordingly.
 This will allow us to see meaningful names for activities, which completes step 3 from list.
 
 Following step is to select only measurements of the mean and standard deviation.
 This is done by subsetting data table.
 Resulting data table will contain only columns that contain "mean()" or "std()" as part of their name (plus "subject" and "activity").
 This completes step 2 from the list.
 
 Next, column names are updated to provide appropriate descriptive names.
 Following is done: "-" removed, name of the functions "mean()", "std()" replaced with "Mean", "Std"- so brackets will be removed, and column name will be in camel case.
 This completes step 4.
 
 Next, dataset is grouped by "subject" and "activity" columns and means are calculated for the rest of the columns.
 Resulting data table is in wide-tidy form.
 
 Result is saved to a file "result.txt".
 Result can be read with following call:
 
 read.table("result.txt",header=T)
 

Following resourses were used: 
Course project FAQ by David Hood - https://class.coursera.org/getdata-011/forum/thread?thread_id=69

