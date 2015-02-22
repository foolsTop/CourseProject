#package required to use startsWith function.
install.packages("gdata")
library(gdata)

#Read separate data sets to varaiables
testSubject <-read.table("./UCI HAR Dataset/test/subject_test.txt",header = F)
testX <-read.table("./UCI HAR Dataset/test/X_test.txt",header = F)
testY <-read.table("./UCI HAR Dataset/test/Y_test.txt",header = F)
trainSubject <-read.table("./UCI HAR Dataset/train/subject_train.txt",header = F)
trainX <-read.table("./UCI HAR Dataset/train/X_train.txt",header = F)
trainY <-read.table("./UCI HAR Dataset/train/Y_train.txt",header = F)

features <- read.table("./UCI HAR Dataset/features.txt",header = F)
activity_lables <- read.table("./UCI HAR Dataset/activity_labels.txt",header = F)

#Set row names for data sets
names_vector <- features[,2]
names(testX)<-names_vector
names(trainX)<-names_vector
names(testSubject) <- "subject"
names(trainSubject) <- "subject"
names(testY) <- "activity"
names(trainY) <- "activity"

#Merge test datasets
testDs <- cbind(testSubject,testY)
testDs <- cbind(testDs,testX)

#Merge train datasets
trainDs <- cbind(trainSubject,trainY)
trainDs <- cbind(trainDs,trainX)

#Merge test and train datasets together.
fullds <- rbind(testDs,trainDs)

#Set descriptive activity names for activities in data set.
fullds[,2] <- as.factor(fullds[,2])
levels(fullds[,2]) <-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#Subset dataset so it will contain only mean and std measurements.
cols <- names(fullds)
substring="mean\\(\\)|std\\(\\)|subject|activity"
cols <- cols[grepl(substring,cols)==T]
fullds <- fullds[,cols]


#Appropriately label the data set with descriptive variable names. 
#Removed symbols "-","(",")"
#Replaced leading "t" and "f" with "Time" and "Freq"
colNames<-names(fullds)
colNames <- gsub("-", "", colNames)
colNames <- gsub("mean\\(\\)", "Mean", colNames)
colNames <- gsub("std\\(\\)", "Std", colNames)
colNames <- gsub("BodyBody", "Body", colNames)
colNames[startsWith(colNames,"t")] <-sub("t","Time",colNames[startsWith(colNames,"t")])
colNames[startsWith(colNames,"f")] <-sub("f","Freq",colNames[startsWith(colNames,"f")])
names(fullds) <-colNames

#groupping data set by subject and activity, and calculating means for the rest of the values.
library(dplyr)
groupedDs <- group_by(fullds,subject,activity)
result  <- summarise_each(groupedDs,funs(mean))

#writing resulting data set to file.
write.table(result,"result.txt",row.name=FALSE)