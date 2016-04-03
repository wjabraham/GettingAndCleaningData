# Code Book for Tidy Dataset

## Tidy dataset variables
* "activity"
* "subject"
* "timebodyacceleration-mean()-x"                 
* "timebodyacceleration-mean()-y"                
* "timebodyacceleration-mean()-z"                 
* "timebodyacceleration-std()-x"                 
* "timebodyacceleration-std()-y"                  
* "timebodyacceleration-std()-z"                 
* "timegravityacceleration-mean()-x"              
* "timegravityacceleration-mean()-y"             
* "timegravityacceleration-mean()-z"              
* "timegravityacceleration-std()-x"              
* "timegravityacceleration-std()-y"               
* "timegravityacceleration-std()-z"              
* "timebodyaccelerationjerk-mean()-x"             
* "timebodyaccelerationjerk-mean()-y"            
* "timebodyaccelerationjerk-mean()-z"             
* "timebodyaccelerationjerk-std()-x"             
* "timebodyaccelerationjerk-std()-y"              
* "timebodyaccelerationjerk-std()-z"             
* "timebodygyroscope-mean()-x"                    
* "timebodygyroscope-mean()-y"                   
* "timebodygyroscope-mean()-z"                    
* "timebodygyroscope-std()-x"                    
* "timebodygyroscope-std()-y"                     
* "timebodygyroscope-std()-z"                    
* "timebodygyroscopejerk-mean()-x"                
* "timebodygyroscopejerk-mean()-y"               
* "timebodygyroscopejerk-mean()-z"                
* "timebodygyroscopejerk-std()-x"                
* "timebodygyroscopejerk-std()-y"                 
* "timebodygyroscopejerk-std()-z"                
* "timebodyaccelerationmagnitude-mean()"          
* "timebodyaccelerationmagnitude-std()"          
* "timegravityaccelerationmagnitude-mean()"       
* "timegravityaccelerationmagnitude-std()"       
* "timebodyaccelerationjerkmagnitude-mean()"      
* "timebodyaccelerationjerkmagnitude-std()"      
* "timebodygyroscopemagnitude-mean()"             
* "timebodygyroscopemagnitude-std()"             
* "timebodygyroscopejerkmagnitude-mean()"         
* "timebodygyroscopejerkmagnitude-std()"         
* "frequencybodyacceleration-mean()-x"            
* "frequencybodyacceleration-mean()-y"           
* "frequencybodyacceleration-mean()-z"            
* "frequencybodyacceleration-std()-x"            
* "frequencybodyacceleration-std()-y"             
* "frequencybodyacceleration-std()-z"            
* "frequencybodyaccelerationjerk-mean()-x"        
* "frequencybodyaccelerationjerk-mean()-y"       
* "frequencybodyaccelerationjerk-mean()-z"        
* "frequencybodyaccelerationjerk-std()-x"        
* "frequencybodyaccelerationjerk-std()-y"         
* "frequencybodyaccelerationjerk-std()-z"        
* "frequencybodygyroscope-mean()-x"               
* "frequencybodygyroscope-mean()-y"              
* "frequencybodygyroscope-mean()-z"               
* "frequencybodygyroscope-std()-x"               
* "frequencybodygyroscope-std()-y"                
* "frequencybodygyroscope-std()-z"               
* "frequencybodyaccelerationmagnitude-mean()"     
* "frequencybodyaccelerationmagnitude-std()"     
* "frequencybodyaccelerationjerkmagnitude-mean()" 
* "frequencybodyaccelerationjerkmagnitude-std()" 
* "frequencybodygyroscopemagnitude-mean()"        
* "frequencybodygyroscopemagnitude-std()"        
* "frequencybodygyroscopejerkmagnitude-mean()"    
* "frequencybodygyroscopejerkmagnitude-std()"  

### Loading Data
The data files were loaded into the following data frames using `read.table`.
* **activitylabels** : Contains the **id** and **label** for each activity.  Loaded from activity_labels.txt.
* **features** : Contains the column names of the test and training datasets.  Loaded from features.txt.
* **xtest** : The test dataset.  Loaded from xtest.txt.
* **ytest** : Activity ids associated with the test dataset.  Loaded from ytest.txt.
* **subjecttest** : Subject ids associated with the test dataset.  Loaded from subject_test.txt.
* **xtrain** : The training dataset.  Loaded from xtrain.txt.
* **ytrain** : Activity ids associated with the training dataset.  Loaded from ytrain.txt.
* **subjecttrain** : Subject ids associated with the training dataset.  Loaded from subject_train.txt.

### Initial Transformations
The following transformations were made to the data:
* Column names **id** and **label** were added to activitylabels**
* Column name **activity** was added to **ytest** and **ytrain**
* Column name **subject** was added to **subjecttest** and **subjecttrain**
* Column names of **xtest** and **xtrain** were named using the values supplied in **features**

### Transformed Test and Training Datasets
Using cbind, the above transformations were used to create intermediate test and training datasets that can be used to easily merge them together.  The two intermediate datasets are:
* **xtestcomplete** : The binding together of **ytest**, **subjecttest**, and **xtest**
* **xtraincomplete** : The binding together of **ytrain**, **subjecttrain**, and **xtrain`**

### Merging Datasets
The test and train datasets do not have a relationship where they can be joined on a common key using merge.  This fact is readily apparent from the README file accompanying the dataset, "The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.".  Instead, these datasets need to be "vertically" merged back together by using rbind in order to recreate the original unpartitioned dataset.  Using rbind, the **xtestcomplete** and **xtraincomplete** were merged together forming **xmergeddata**.

### Extracting mean and std Measurements
Using grep, the columns in the dataset containg "mean()" or "std()" were extracted from **xmergeddata**.  Additionally, the "activity" and "subject" columns were also extracted wusing grep, since these will be needed later in calculating the column averages.

### Adding Descriptive Activity Names
The activity ids in **xmergeddata** were replaced by the activity label using the **match** function.  This function matches the activity id in **xmergeddata** with the activity id in **activitylabels** and replaces it with the more descriptive activity label.  The resultant dataset is called **stdandmean**.

### Descriptive Variable Names
The variable names were modified to be more descriptive using the points identified in the lecture slides:
* All lower case
* Descriptive
* Not duplicated

Using these points as a guideline, the variable names were modified as follows using the **gsub** function
* gsub("^t", "time", colnames(stdandmean))
* gsub("^f", "frequency", colnames(stdandmean))
* gsub("Acc", "acceleration", colnames(stdandmean))
* gsub("Gyro", "gyroscope", colnames(stdandmean))
* gsub("Mag", "magnitude", colnames(stdandmean))
* gsub("BodyBody", "body", colnames(stdandmean))
* tolower(colnames(stdandmean))

This resulted in the following variable names
* "timebodyacceleration-mean()-x"                 
* "timebodyacceleration-mean()-y"                
* "timebodyacceleration-mean()-z"                 
* "timebodyacceleration-std()-x"                 
* "timebodyacceleration-std()-y"                  
* "timebodyacceleration-std()-z"                 
* "timegravityacceleration-mean()-x"              
* "timegravityacceleration-mean()-y"             
* "timegravityacceleration-mean()-z"              
* "timegravityacceleration-std()-x"              
* "timegravityacceleration-std()-y"               
* "timegravityacceleration-std()-z"              
* "timebodyaccelerationjerk-mean()-x"             
* "timebodyaccelerationjerk-mean()-y"            
* "timebodyaccelerationjerk-mean()-z"             
* "timebodyaccelerationjerk-std()-x"             
* "timebodyaccelerationjerk-std()-y"              
* "timebodyaccelerationjerk-std()-z"             
* "timebodygyroscope-mean()-x"                    
* "timebodygyroscope-mean()-y"                   
* "timebodygyroscope-mean()-z"                    
* "timebodygyroscope-std()-x"                    
* "timebodygyroscope-std()-y"                     
* "timebodygyroscope-std()-z"                    
* "timebodygyroscopejerk-mean()-x"                
* "timebodygyroscopejerk-mean()-y"               
* "timebodygyroscopejerk-mean()-z"                
* "timebodygyroscopejerk-std()-x"                
* "timebodygyroscopejerk-std()-y"                 
* "timebodygyroscopejerk-std()-z"                
* "timebodyaccelerationmagnitude-mean()"          
* "timebodyaccelerationmagnitude-std()"          
* "timegravityaccelerationmagnitude-mean()"       
* "timegravityaccelerationmagnitude-std()"       
* "timebodyaccelerationjerkmagnitude-mean()"      
* "timebodyaccelerationjerkmagnitude-std()"      
* "timebodygyroscopemagnitude-mean()"             
* "timebodygyroscopemagnitude-std()"             
* "timebodygyroscopejerkmagnitude-mean()"         
* "timebodygyroscopejerkmagnitude-std()"         
* "frequencybodyacceleration-mean()-x"            
* "frequencybodyacceleration-mean()-y"           
* "frequencybodyacceleration-mean()-z"            
* "frequencybodyacceleration-std()-x"            
* "frequencybodyacceleration-std()-y"             
* "frequencybodyacceleration-std()-z"            
* "frequencybodyaccelerationjerk-mean()-x"        
* "frequencybodyaccelerationjerk-mean()-y"       
* "frequencybodyaccelerationjerk-mean()-z"        
* "frequencybodyaccelerationjerk-std()-x"        
* "frequencybodyaccelerationjerk-std()-y"         
* "frequencybodyaccelerationjerk-std()-z"        
* "frequencybodygyroscope-mean()-x"               
* "frequencybodygyroscope-mean()-y"              
* "frequencybodygyroscope-mean()-z"               
* "frequencybodygyroscope-std()-x"               
* "frequencybodygyroscope-std()-y"                
* "frequencybodygyroscope-std()-z"               
* "frequencybodyaccelerationmagnitude-mean()"     
* "frequencybodyaccelerationmagnitude-std()"     
* "frequencybodyaccelerationjerkmagnitude-mean()" 
* "frequencybodyaccelerationjerkmagnitude-std()" 
* "frequencybodygyroscopemagnitude-mean()"        
* "frequencybodygyroscopemagnitude-std()"        
* "frequencybodygyroscopejerkmagnitude-mean()"    
* "frequencybodygyroscopejerkmagnitude-std()"  

### Creating Tidy Dataset
Using the dplyr package, the the **stdandmean** datset was grouped by the activity and subject variables, and then, using summarize_each to apply the mean function over each of the mean() and std() variables.
```r
tidydata <- stdandmean %>% group_by(activity,subject) %>% summarise_each(funs(mean),-subject,-activity)
```
