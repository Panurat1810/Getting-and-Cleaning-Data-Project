x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)
Merged_Data<-cbind(subject,y,x)
##merge data into one dataset

TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
##select required data fro this assignment

TidyData$code <- activity[TidyData$code, 2]
##sub code in row to with activity name accordingly

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
## correcting the name by giving info from features_info

final_data<-TidyData%>%
  group_by(subject,activity)%>%
  summarise_all(funs(mean))
##new data set with activity and average of each, accordingly to step 4

write.table(final_data,"FinalData.txt",row.names = FALSE)
##write a table
