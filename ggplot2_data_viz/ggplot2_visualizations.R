library(ggplot2)
library(reshape2)
setwd('C:/Users/User/Documents/MSPA/PREDICT_455/group_project')
allD<-read.csv("AllCountsFile.csv", header=TRUE)
allD<-allD[-19,]
allD<-allD[,0:4]
head(allD)
str(allD)

#check class of variable
class(allD$Total_PTs)

#need to remove the comma in the values
allD$Total_PTs<-gsub(",","",allD$Total_PTs)
allD$Total_HPTs<-gsub(",","",allD$Total_HPTs)
allD$Total_PPTs<-gsub(",","",allD$Total_PPTs)
head(allD)


#then convert factor to numeric
#also, renaming variables
allD$Total_Dialysis_Patients<-as.numeric(as.character(allD$Total_PTs))
allD$Total_Hemodialysis_Patients<-as.numeric(as.character(allD$Total_HPTs))
allD$Total_Peritoneal_Dialysis_Patients<-as.numeric(as.character(allD$Total_PPTs))

str(allD)

#dropping the variables not needed
allD<-allD[c("Year","Total_Dialysis_Patients","Total_Hemodialysis_Patients","Total_Peritoneal_Dialysis_Patients")]

str(allD)

#now using melt to convert to long format for plotting multiple variables with ggplot

test_data<-melt(allD, id="Year")

#print plot into an svg file
theme_clear <- theme_bw() + theme(plot.background=element_rect(fill="white",colour=NA)) +
  theme(panel.grid.major.y=element_blank(),panel.grid.minor=element_blank())


svg(file = "plot_TOtalPatientsPerYear.svg", width = 11, height = 8.5)

ggplot(data=test_data, aes(x=Year, y=value, colour=variable)) +
  geom_line()+
  geom_point(size=4) +
  ylab("Number of Patients") +
  ggtitle("Total Number of Patients \nby Year")+
  theme(plot.title=element_text(lineheight=.8,face="bold"))+theme_clear +
  scale_colour_manual(labels=c("Total Dialysis Patients","Total Hemodialysis Patients","Total Peritoneal Dialysis"), values=c("#990000","#000000","#3C3C3C"))

dev.off()
