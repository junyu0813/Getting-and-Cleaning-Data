# Load the file into R
  trainx <- read.table("D:/R/X_train.txt", header=F, sep="")
  testx <- read.table("D:/R/X_test.txt", header=F, sep="")
  
# Read features.txt, use it as column names
  cname <-readLines("D:/R/features.txt")
  colnames(testx) <-cname
  colnames(testx) <-cname
  
# 1) Merge the training and the test sets to create one data set
  df <- rbind(trainx, testx)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# Extract column names which contain "mean()" and "std()"
df1 <- df[, grepl("mean()", cname, ignore.case=TRUE)|grepl("std()", cname, ignore.case=TRUE)]

# 3) Uses descriptive activity names to name the activities in the data set
## Load Y_train.txt and Y_test.txt and then merge them
  trainy <- read.table("D:/R/Y_train.txt", header=F, sep="")
  testy <- read.table("D:/R/Y_test.txt", header=F, sep="")
  lname <- rbind(trainy and testy)
  
## Load activity label and merge with lname
  lname <- merge(lname, activity, by = "V1")
