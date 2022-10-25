clear all
close all
clc
                                 
% This is a demonstration of the synthetic features selection. This code selects pertinent samples among 10 synthetic features generated
% by artificial immune system using mutation probability about 0.2
% differences between synthetics and the real feature is managed by the
% mutation probability where small values modify only one or two components in the feature vector. 

load DATA Original_Signature Synthetics_Scriptor

R=Original_Signature;
MCC=Synthetics_Scriptor;

simil=[];
for j = 1:10   % 10 is the number of generated synnthetics
   
similarity = Cosine_Similarity( R(:), MCC(:,j) );
simil  = [simil  similarity];
end

ma=1;
for ta=1:1:10
d1=simil(1:ta);
moy1(ma)=mean(d1);
moy2(ma)= round(mean(d1),4);
ma=ma+1;
end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
[na1 ba1 ]=sort(moy2,'descend')     
Ranking=MCC(:,ba1);
moy2=moy2(:,ba1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


final= mean(moy2) + 0.7 *std(moy2);
final1=round(final,4)

res = ismember(final1,moy2);

if res == 1 
[s1 s2]=find(moy2==final1);
s3=s2(1);
else
[s1 s2]=find(moy2>final1) 
s0=length(s2)
s3=s2(s0)
end

Number_Of_Synthetics=s3

save Criteria Number_Of_Synthetics Ranking


