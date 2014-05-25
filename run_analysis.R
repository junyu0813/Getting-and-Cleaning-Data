# Load the file into R
trainx <- read.table("D:/R/X_train.txt", header=F, sep="")
testx <- read.table("D:/R/X_test.txt", header=F, sep="")

# Add subjective to the data frame and merge
subj_train<- read.table("D:/R/subject_train.txt", header=F, sep="")
subj_test<- read.table("D:/R/subject_test.txt", header=F, sep="")
subj <- rbind(subj_train, subj_test)

# Remove used data to save memory
rm(list=c("subj_test", "subj_train"))

# Read features.txt, use it as column names
cname <-read.table("D:/R/features.txt")


# 1) Merge the training and the test sets to create one data set
## merge and add column name
df <- rbind(trainx, testx)
colnames(df) <-cname$V2

# Remove used data to save memory
rm(list=c("trainx", "testx"))

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# Extract column names which contain "mean()" and "std()"
df <- df[, grepl("mean()", cname$V2, ignore.case=TRUE)|grepl("std()", 
                            cname$V2, ignore.case=TRUE)]

# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive activity names
## Load Y_train.txt and Y_test.txt and then merge them
trainy <- read.table("D:/R/Y_train.txt", header=F, sep="")
testy <- read.table("D:/R/Y_test.txt", header=F, sep="")
lname <- rbind(trainy, testy)
 
## Load activity label. 
activity <- read.table("D:/R/activity_labels.txt", header=F, sep="")
## merge with lname to match the activity names with the presentative numbers
lname <- merge(lname, activity, by = "V1")

## Add subjective and activity to the exits data frame. id is subject (person).
df <-cbind(id=as.factor(subj$V1), activity=lname$V2, df)

# 5) Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.

## Load plyr package
library(plyr)

## Define function
mymean <-function(x) mean(x, na.rm = T)

## Create new data frame
new_df <-ddply(df, .(id, activity), colwise(mymean))

## output
write.table(new_df, "D:/R/new_df.txt", row.names = F, quote = F)
