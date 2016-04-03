# Code Book for Tidy Dataset

## Tidy dataset variables

| Variable											| Data Type				|
|:-------------------------------------------------:|:---------------------:|
| "activity"										|			string		|
| "subject"											|			int			|
| "timebodyacceleration-mean()-x"           		|    		numeric		|
| "timebodyacceleration-mean()-y"           		|    		numeric		|
| "timebodyacceleration-mean()-z"           		|      		numeric		|
| "timebodyacceleration-std()-x"            		|     		numeric		|
| "timebodyacceleration-std()-y"            		|      		numeric		|
| "timebodyacceleration-std()-z"            		|     		numeric		|
| "timegravityacceleration-mean()-x"        		|      		numeric		|
| "timegravityacceleration-mean()-y"        		|     		numeric		|
| "timegravityacceleration-mean()-z"        		|      		numeric		|
| "timegravityacceleration-std()-x"         		|     		numeric		|
| "timegravityacceleration-std()-y"         		|      		numeric		|
| "timegravityacceleration-std()-z"         		|     		numeric		|
| "timebodyaccelerationjerk-mean()-x"       		|      		numeric		|
| "timebodyaccelerationjerk-mean()-y"       		|     		numeric		|
| "timebodyaccelerationjerk-mean()-z"       		|      		numeric		|
| "timebodyaccelerationjerk-std()-x"        		|     		numeric		|
| "timebodyaccelerationjerk-std()-y"        		|      		numeric		|
| "timebodyaccelerationjerk-std()-z"        		|     		numeric		|
| "timebodygyroscope-mean()-x"              		|      		numeric		|
| "timebodygyroscope-mean()-y"              		|     		numeric		|
| "timebodygyroscope-mean()-z"              		|      		numeric		|
| "timebodygyroscope-std()-x"               		|     		numeric		|
| "timebodygyroscope-std()-y"               		|      		numeric		|
| "timebodygyroscope-std()-z"               		|     		numeric		|
| "timebodygyroscopejerk-mean()-x"        			|     		numeric		|
| "timebodygyroscopejerk-mean()-y"          		|     		numeric		|
| "timebodygyroscopejerk-mean()-z"          		|     		numeric		|
| "timebodygyroscopejerk-std()-x"           		|     		numeric		|     
| "timebodygyroscopejerk-std()-y"          			|     		numeric		|      
| "timebodygyroscopejerk-std()-z"           		|     		numeric		|     
| "timebodyaccelerationmagnitude-mean()"    		|     		numeric		|      
| "timebodyaccelerationmagnitude-std()"     		|     		numeric		|     
| "timegravityaccelerationmagnitude-mean()" 		|     		numeric		|      
| "timegravityaccelerationmagnitude-std()"  		|     		numeric		|     
| "timebodyaccelerationjerkmagnitude-mean()"		|     		numeric		|      
| "timebodyaccelerationjerkmagnitude-std()" 		|     		numeric		|     
| "timebodygyroscopemagnitude-mean()"       		|     		numeric		|      
| "timebodygyroscopemagnitude-std()"        		|     		numeric		|     
| "timebodygyroscopejerkmagnitude-mean()"   		|     		numeric		|      
| "timebodygyroscopejerkmagnitude-std()"    		|     		numeric		|     
| "frequencybodyacceleration-mean()-x"      		|     		numeric		|      
| "frequencybodyacceleration-mean()-y"      		|     		numeric		|     
| "frequencybodyacceleration-mean()-z"      		|     		numeric		|      
| "frequencybodyacceleration-std()-x"       		|     		numeric		|     
| "frequencybodyacceleration-std()-y"       		|     		numeric		|      
| "frequencybodyacceleration-std()-z"       		|     		numeric		|     
| "frequencybodyaccelerationjerk-mean()-x"  		|     		numeric		|      
| "frequencybodyaccelerationjerk-mean()-y"  		|     		numeric		|     
| "frequencybodyaccelerationjerk-mean()-z"  		|     		numeric		|      
| "frequencybodyaccelerationjerk-std()-x"   		|     		numeric		|     
| "frequencybodyaccelerationjerk-std()-y"   		|     		numeric		|      
| "frequencybodyaccelerationjerk-std()-z"   		|     		numeric		|     
| "frequencybodygyroscope-mean()-x"         		|     		numeric		|      
| "frequencybodygyroscope-mean()-y"         		|     		numeric		|     
| "frequencybodygyroscope-mean()-z"         		|     		numeric		|      
| "frequencybodygyroscope-std()-x"          		|     		numeric		|     
| "frequencybodygyroscope-std()-y"          		|     		numeric		|      
| "frequencybodygyroscope-std()-z"        		  	|     		numeric		|     
| "frequencybodyaccelerationmagnitude-mean()"		|     		numeric		|     
| "frequencybodyaccelerationmagnitude-std()"		|     		numeric		|     
| "frequencybodyaccelerationjerkmagnitude-mean()"	|     		numeric		| 
| "frequencybodyaccelerationjerkmagnitude-std()"	|     		numeric		| 
| "frequencybodygyroscopemagnitude-mean()"   		|     		numeric		|     
| "frequencybodygyroscopemagnitude-std()"     		|     		numeric		|   
| "frequencybodygyroscopejerkmagnitude-mean()"    	|     		numeric		|
| "frequencybodygyroscopejerkmagnitude-std()"  		|     		numeric		|

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

### Creating Tidy Dataset
Using the dplyr package, the the **stdandmean** datset was grouped by the activity and subject variables, and then, using summarize_each to apply the mean function over each of the mean() and std() variables.
```r
tidydata <- stdandmean %>% group_by(activity,subject) %>% summarise_each(funs(mean),-subject,-activity)
```
