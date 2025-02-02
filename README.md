Facial Features Based Human Age, Gender And Ethnicity Identification System 
This project develops a convolutional neural network (CNN) based deep learning network to automatically classify age, gender and ethnicity. To this end, we propose a simple convolutional net design that can be employed even when there is a small amount of learning data. For image-based gender, age, and ethnicity estimates, deep neural networks with pre-trained weights are used. VGG is used to investigate transfer learning. To increase prediction accuracy, examination on the effects of modifications in various design schemes and training settings on pre-trained models is done. Finally, a hierarchy of deep CNNs is explored, which first classifies participants by gender and then predicts age and ethnicity using separate models.

DATASETS COLLECTION
 The data for this study was gathered from UTK dataset. To illustrate the output, the data is separated into multiple folders. The system's folders are Gender classification, Age classification, and Race classification. In the Gender classification, we take the system's male and female images. Then, in the Age classification, we take data from people aged 1-100. Finally, in the race classification section, we use data from the system's five country ethnicity data sets.

REQUIREMENTS
•	Matlab R2022a 
•	Deep learning toolbox
•	Deep network designer


HOW TO RUN THE PROJECT
•	Open matlab software.
•	Open the GUI created.
•	Click on load database, where the network which determines the age/gender/race will be loaded.
•	Then choose the image from folder images or through webcam (live image).  Image chosen will be appeared on the GUI.
•	Click on the AGE/GENDER/RACE button which will show you the age, gender and race respectively.
