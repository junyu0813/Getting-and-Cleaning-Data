# Load the file into R
  trainx <- read.table("D:/R/X_train.txt", header=F, sep="")
  testx <- read.table("D:/R/X_test.txt", header=F, sep="")
  
# Read features.txt, use it as column names
  cname <-readLines("D:/R/features.txt")
  colnames(testx) <-cname
  colnames(testx) <-cname
  
# 1) Merge 
df1 <- df[, grepl("mean()", cname, ignore.case=TRUE)|grepl("std()", cname, ignore.case=TRUE)]
