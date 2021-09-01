#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}
## program...
bedfile = read.table(args[1], header=F)

if (!require("dplyr")) install.packages("dplyr")
library(dplyr)

df_out <- bedfile %>%
  group_by(bedfile$V4) %>%
  summarise(
    V2 = min(V2, na.rm = TRUE),
    V3 = max(V3, na.rm = TRUE),
  ) 
df_out$V1<- c(rep(as.character(bedfile$V1[1]),nrow(df_out)))

write.table(df_out[,c(4,2,3,1)], file=args[2], row.names=FALSE, col.names = F,quote = F)
#write.table(df_out[,c(4,2,3,1)], file=args[2], row.names=FALSE, col.names = F,quote = F)
#write.table(df_out, file="testing", row.names=FALSE, col.names = F,quote = F)
