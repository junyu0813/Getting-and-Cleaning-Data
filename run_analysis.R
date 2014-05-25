# Load the file into R
trainx <- read.table("D:/R/X_train.txt", header=F, sep="")
testx <- read.table("D:/R/X_test.txt", header=F, sep="")

# Add subjective to the data frame
subj_train<- read.table("D:/R/subject_train.txt", header=F, sep="")
subj_test<- read.table("D:/R/subject_test.txt", header=F, sep="")

## merge two set
subj <- rbind(subj_train, subj_test)

# Read features.txt, use it as column names
cname <-read.table("D:/R/features.txt")


# 1) Merge the training and the test sets to create one data set
df <- rbind(trainx, testx)
# Add column names
colnames(df) <-cname$V2


# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# Extract column names which contain "mean()" and "std()"
df <- df[, grepl("mean()", cname$V2, ignore.case=TRUE)|grepl("std()", 
                            cname$V2, ignore.case=TRUE)]

# 3) Uses descriptive activity names to name the activities in the data set
## Load Y_train.txt and Y_test.txt and then merge them
trainy <- read.table("D:/R/Y_train.txt", header=F, sep="")
testy <- read.table("D:/R/Y_test.txt", header=F, sep="")
lname <- rbind(trainy, testy)

## Load activity label and merge with lname
activity <- read.table("D:/R/activity_labels.txt", header=F, sep="")
lname <- merge(lname, activity, by = "V1")

## Add subjective
df <-cbind(id=subj$V1, activity=lname$V2, df)
