#############################################################################################
##              R code for Exploratory data analysis on chart champ data  ##################
##              Shatrunjai                                                ##################
##              08/21/2016                                                ##################
#############################################################################################

#Load important R libraries
library(stats);
library(nnet);
library(MASS);
library(caret);
library(klaR);
library(aplpack);
library(RODBC);
library(mlbench)
library(corrplot)						
library(caret)						
library(usdm)						
library(gbm)						
library(lars)						
library(colorspace)						
library(alr3)						
library(caret)						
library(gbm)		
library(car)
library(glmnet)
library(car)
require(caret)
library(vioplot)
require(nnet)
library(gbm)
library(dismo)
library(caret)
library(gbm)
library(foreach)
library(doParallel)
library(magrittr)
library(plyr)
library(foreign)
library(stats);
library(nnet);
library(MASS);
library(caret);
library(klaR);
library(aplpack);
library(RODBC);
library(mlbench)
library(corrplot)						
library(caret)						
library(usdm)						
library(gbm)						
library(lars)						
library(colorspace)						
library(alr3)						
library(caret)						
library(gbm)		
library(car)
library(glmnet)
library(car)
require(caret)
library(vioplot)
require(nnet)
library(RODBC)
library(corrplot)
library(caret)
library(usdm)
library(gbm)
library(lars)
library(colorspace)
library(alr3)
library(caret)
library(gbm)
library(glmnet)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(zoom)
library(randomForest)
library(shiny)
library(car)
library(ggplot2)
library('corrplot') 
library(Matrix)

#Set working directory
cat("\014") 
setwd("C:/Chartchamp")

#GET DATA FROM SQL SERVER
myconn <- odbcConnect("SQL_******","*********","********")
champ_new<-sqlQuery(myconn,"select
                A.*,
                    B.crimeindex,
                    B.Population,
                    B.[House Price]
                    from
                    DBO.CHART_SUMMARY_02 A
                    LEFT OUTER JOIN 
                    DBO.CHART_CRIME B
                    ON A.DISTRICT=B.Town
                    ")
#Check if data imported correctly
names(champ_new)
dim(champ_new)

#Save it to R 
save(champ_new,file="champ_data_new.Rda")

#Reimport data into R
champ_new<-load("champ_data_new.Rda")
names(champ_new)

#make a copyname
champ_copy<-champ_new

#Attach champ_01
attach(champ_01)

# select variables  varlist_01
champ_01<-champ_new[c(-2,-44,-34,-43,-47)]
names(champ_01)

#############################################################################################
##             Correlation matrix for all these variables                   ##################
#############################################################################################
# get correlations
data <- as.data.frame(champ_01)
data[is.na(data)] <- 0
M <- cor(champ_01, use="complete.obs") 

#Write correlation matrix to csv file for analysis
write.csv(data.frame(M),file="correlation_SAT.csv")

#Find highest correlations
highCorr_others	<-	findCorrelation(M,	cutoff	=	0.8,	names=TRUE)
as.table(data.frame(M))
head(M)

#package corrplot for plotting high correlations
library('corrplot') 
corrplot(M, method = "circle") #plot matrix

#Reason to exclude certain variables from analysis is high corr coef. (>0.9)
cor.test(champ_01$SAT_minus_HOUSEPRICE,champ_01$`# of Educators to be Evaluated`)

###################################################################################
#Running a desicion tree on DATA using SAT_Ranking - House PRICE ranking as target#
###################################################################################
fit_all<-rpart(champ_01$SAT_minus_HOUSEPRICE~.,method="class",data=champ_01,cp=0.0025)

#view tree results
printcp(fit_all) # display the results 
plotcp(fit_all) # visualize cross-validation results 
summary(fit_all) # detailed summary of splits

#Get optimal complexity parameter
cp=fit_all$cptable[which.min(fit_all$cptable[,'xerror']),'CP']

#Find important variables based on tree
vi=fit_all$variable.importance
for (i in 1:length(vi))
{
  print (i)
  print (vi[i])
}

#Plot the tree
plot(fit_all, uniform=TRUE,main="Classification Tree for which rules case things to goto FUW")
text(fit_all, use.n=TRUE, all=TRUE, cex=.8)

####################################################################################
### Use Gradient Boosting Machienes (GBM) model to find important variables #########
####################################################################################

# FIT GBM MODEL ON OPTIMIZED PARAMETERS FROM GRID SEARCH (not shown)
fit <- gbm(champ_01$SAT_minus_HOUSEPRICE~.,data=champ_01,n.trees = 100000,interaction.depth = 10)

# SUMMARIZE THE FIT
summary(fit)

###END###
