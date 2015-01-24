#load librarys
library(dplyr)
#merges files
#read X,Y and Subject. Parameter is if load 'test' o 'train'
load <-function(test) {
        x<-read.table(paste('UCI HAR Dataset/',test,'/X_',test,'.txt',sep = ''))
        y<-read.table(paste('UCI HAR Dataset/',test,'/y_',test,'.txt',sep = ''))
        subj<-read.table(paste('UCI HAR Dataset/',test,'/subject_',test,'.txt',sep = ''))
        tidy1<-cbind(subj,y,x)
        
        #str(tidy1)
        tidy1
}
##convert numbers in labels
convert<-function(x){
        if(i==1) x='WALKING'
        else if(i==2) x='WALKING_UPSTAIRS'
        else if(i==3) x='WALKING_DOWNSTAIRS'
        else if(i==4) x='SITTING'
        else if(i==5) x='STANDING'
        else if(i==6) x='LAYING'
        
}
#########
#Point 1
#########
#load test
test<-load('test')
#load train
train<-load('train')
#merge test and train
total<-rbind(test,train)
#########
#Point 2
#########
#read  features column names. Drop first column
feat<-read.table('UCI HAR Dataset/features.txt')
feat<-feat$V2
#set column names
colnames(total)<-c('Subject_ID','TrainingLabels',as.character(feat))
#select means and std
colmean<-grep('*mean*',colnames(total))
colstd<-grep('*std*',colnames(total))
col<-c(1,2,colmean,colstd)
total<-total[,col]
#########
#Point 3
#########
#head(total$TrainingLabels,n = 50)
#change integers for readable values
total$TrainingLabels<-lapply(total$TrainingLabels,function(x){
        if(x==1) x='WALKING'
        else if(x==2) x='WALKING_UPSTAIRS'
        else if(x==3) x='WALKING_DOWNSTAIRS'
        else if(x==4) x='SITTING'
        else if(x==5) x='STANDING'
        else if(x==6) x='LAYING' 
})
#head(total$TrainingLabels,n = 50)
#########
#Point 4
#########
#Change de colnames. Use caps to undestand better 
colnames(total)<-sapply(colnames(total),function(x){
        x= gsub('-mea','Mea',x) 
        x= gsub('[[:punct:]]','',x)
        x= gsub('std','Std',x) 
        x= gsub('max','Max',x) 
        x= gsub('mad','Mad',x)
        x= gsub('min','Min',x) 
        x= gsub('energy','Energy',x)
        x= gsub('entropy','Entropy',x)
        x= gsub('iqr','Iqr',x)
        x= gsub('arCoeff','ArCoeff',x)
        x= gsub('sma','Sma',x)
        x= gsub('correlation','Correlation',x)
        x= gsub('skewness','Skewness',x)
        x= gsub('kurtosis','Kurtosis',x)
        x= gsub('bandsEnergy','BandsEnergy',x)
})
#########
#Point 5
#########
#unlist the TrainingLabels I need a vector to group by
total$TrainingLabels<-unlist(total$TrainingLabels)
#I group by TrainingLabels and SubjectID, Then I sumarise each variable with mean function. The result is 180x81 data.frame
totalGroupMean<-total
totalGroupMean<-totalGroupMean %>%group_by(TrainingLabels,SubjectID)%>%summarise_each(funs(mean))
#I write the data in a file called tidy5.txt
write.table(x = totalGroupMean,file = 'tidy5.txt',row.names = FALSE)
