clear all
close all
clc

% Offlie signature verification conducted on a writer from CEDAR  signature dataset

% Train the SVS by using a single real feature based on HOT descriptor and one random forgery

% Performance evaluation is carried out using 23 Genuine signature features and 24 skilled forgeries 

% Code is developed using MATLAB 2016



load DATA Original_Signature Rand_Forg_SBASIC Remaining Skilled_Forg

% Extract training samples

Train_Set=[Original_Signature Rand_Forg_SBASIC];
R=Train_Set;


% Extract test samples

Test_Set=[Remaining Skilled_Forg];
T=Test_Set;

% Train the SVM based verifier

App=2;
vectApp= zeros(App,1);                                                                        
vectApp(1,:)=1;                                                                                  
vectApp(2,:)=-1;       

Test=47;
vectTest= zeros(Test,1);                                                                         
vectTest(1:23,:)=1;             
vectTest(24:47,:)=-1;         

svmstruct=svmtrain(R',vectApp(:),'Kernel_function','rbf', 'rbf_sigma',1,'method','smo','BoxConstraint',1);


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



   
 


