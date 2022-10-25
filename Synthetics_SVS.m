clear all
close all
clc

% Offline signature verification conducted on a writer from CEDAR signature dataset

% Train the SVS by using a single real feature plus generated synthetic features based on HOT descriptor and the same number for random forgeries

% Performance evaluation is carried out using 23 Genuine signature features and 24 skilled forgeries 

% Code is developed using MATLAB 2016


load DATA Original_Signature Remaining Skilled_Forg Second_class_Train_Synthetics
load Criteria Number_Of_Synthetics Ranking

% Extract training samples (Positive class: 1 Real sample+ 1 selected Synthetics, Negative class: 2 Random forgeries)

First_Class_Train=[Original_Signature Ranking(:,1:Number_Of_Synthetics)];
Train_Set=[First_Class_Train Second_class_Train_Synthetics];
R=Train_Set;

% Extract test samples:

Test_Set=[Remaining Skilled_Forg];
T=Test_Set;

%  Train the SVS

App=(1+Number_Of_Synthetics)*2;
vectApp= zeros(App,1);                                                                         
vectApp(1:(1+Number_Of_Synthetics),:)=1;                                                                                  
vectApp((2+Number_Of_Synthetics):(1+Number_Of_Synthetics)*2,:)=-1;        

Test=47;
vectTest= zeros(Test,1);                                                                           
vectTest(1:23,:)=1;                                                                                  
vectTest(24:47,:)=-1;         
         
svmstruct=svmtrain(R,vectApp(:),'Kernel_function','rbf', 'rbf_sigma',1,'method','smo','BoxConstraint',1);


% Performance evaluation using : FAR, FRR, AER

[s_test, f_test]= svmdecision(T',svmstruct);
 
  FRR=0;
        FAR=0;
        for i=1:23
            if s_test(i)==-1
               FRR=FRR+1;
            end
        end
        for i=24:47
            if s_test(i)==1
               FAR=FAR+1;
            end
        end
        FRR1=(FRR/23)*100;
        FAR1=(FAR/24)*100;

AER=(FRR1+FAR1)/2

