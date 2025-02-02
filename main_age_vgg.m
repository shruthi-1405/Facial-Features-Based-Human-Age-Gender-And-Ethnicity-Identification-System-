% Load Initial Parameters
clc
clear all
close all

% Import Data
 imdsTrain = imageDatastore("D:\AGE & GENDER IDENTIFICATION\face-age-gender_20190901\face-age-gender\UTK\AGE","IncludeSubfolders",true,"LabelSource","foldernames");
 [imdsTrain, imdsValidation] = splitEachLabel(imdsTrain,0.8,"randomized");
 save('imds.mat','imdsTrain','imdsValidation');

% Load The Pretrained VGG-16 Net 
 net=vgg16;
 layers=[imageInputLayer([200 200 3])
     net(2:end-3)
     fullyConnectedLayer(34)
     softmaxLayer
     classificationLayer]

 %%%%%%% TRAINING THE NETWORK %%%%%%
  opt=trainingOptions("adam",'MaxEpochs',120,'InitialLearnRate',0.0001, Plots="training-progress")
  [net, traininfo] = trainNetwork(imdsTrain,layers,opt);
  save('net_age_vgg16.mat', 'net');


  %%%%%%% LOAD THE TRAINED FEATURES %%%%%%%%%%%%%%
   load ('net_age_vgg16.mat'); 


   %%%%%%%%%% TEST THE SYS WITH VALIDATION IMAGES %%%%%%%%%%
   [class_out,probs]=classify(net,imdsValidation);

   %%%%%%%%%%%%%%% PERFORMANCE EVALUATION %%%%%%%%%%%%%%
  validationError = mean(class_out ~= imdsValidation.Labels);
  disp("Validation error: " + validationError*100 + "%")

 %Plot the confusion matrix
 
   cm = confusionchart(imdsValidation.Labels,class_out);
   cm.Title = "Confusion Matrix for Validation Data";
   cm.ColumnSummary = "column-normalized";
   cm.RowSummary = "row-normalized";



%%%%%%%%%%%%%testing%%%%%%%%%%%%%%%%%%%%%%

clear all;
load ('net_age_Resnet.mat');

[FileName,PathName] = uigetfile('.jpg;.png;.bmp;.jfif','Select an image');
test_img=imread(strcat(PathName,FileName));
FDetect = vision.CascadeObjectDetector;
BB = step(FDetect,test_img);
figure,

imshow(test_img); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;
class_out=[]
face=[]
for i=1:size(BB,1)
    face{i} = imresize(imcrop(test_img,BB(i,:)),[200 200 ]);
    class_out{i}=classify(net,face{i});
    subplot(1,size(BB,1),i);
    imshow(uint8(face{i})); 
    title(string(class_out{i}));
end



