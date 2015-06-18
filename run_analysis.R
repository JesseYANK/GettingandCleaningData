## Download the data
URL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
download.file(URL,destfile="data.zip",method="curl");
unzip("data.zip");

##Step_1 Merges the training and the test sets to create one data set.
activity_label<-read.table("UCI HAR Dataset//activity_labels.txt",header=FALSE)
featrues<-read.table("UCI HAR Dataset//features.txt",header=FALSE)
X_test<-read.table("UCI HAR Dataset//test//X_test.txt",header=FALSE)
subject_test<-read.table("UCI HAR Dataset//test//subject_test.txt",header=FALSE)
y_test<-read.table("UCI HAR Dataset//test//y_test.txt",header=FALSE)
X_train<-read.table("UCI HAR Dataset//train//X_train.txt",header=FALSE)
subject_train<-read.table("UCI HAR Dataset//train//subject_train.txt",header=FALSE)
y_train<-read.table("UCI HAR Dataset//train//y_train.txt",header=FALSE)

##Merge the training and test set
X<-rbind(X_test,X_train)
names(X)<-featrues[,2]
Subject<-rbind(subject_test,subject_train)
Y<-rbind(y_test,y_train)
Y<-activity_label[Y$V1,2]
names(X)<-gsub("mean","Mean",names(X));  ## capitalize M
names(X)<-gsub("std","Std",names(X));  ## capitalize S
names(X)<-gsub("\\(\\)","",names(X));  ##Remove "()"
names(X)<-gsub("-","",names(X));   ##Remove "-"

## Step_2 Extracts only the measurements on the mean and standard 
## deviation for each measurement.
select_X<-X[,grep("mean\\(\\)|std\\(\\)",featrues[,2])]
names(select_X)<-gsub("()","",names(select_X))

##Step_3 Appropriately labels the data set with descriptive activity 
# names. 
cleaned_data<-data.frame(Activity=Y,SubjectID=Subject$V1,select_X)
cleaned_data<-cleaned_data[order(cleaned_data[,2]),]
write.table(cleaned_data,"cleaned_data.txt",row.names=FALSE)


##Creates a second, independent tidy data set with the average of 
##each variable for each activity and each subject. 
Activity<-sort(activity_label[,2])
ID<-sort(unique(Subject$V1))
tidy <- matrix(NA, nrow=length(Activity)*length(ID), ncol=dim(cleaned_data)[2]) 
tidy <- as.data.frame(tidy)
row<-1
for (activity in Activity){
    for (subject in ID ){
      tidy[row,1]=activity
      tidy[row,2]=subject
      tmp=cleaned_data[cleaned_data$Activity==activity & cleaned_data$SubjectID==subject,]
      tidy[row,3:dim(tmp)[2]]=colMeans(tmp[,3:dim(tmp)[2]])
      row<-row+1
    }
}
names(tidy)<-names(cleaned_data)
write.table(tidy,"tidy_data.txt",row.names=FALSE,col.names=TRUE)




