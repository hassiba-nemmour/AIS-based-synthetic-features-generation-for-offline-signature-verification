function [ similarity ] = Cosine_Similarity ( vect1, vect2 )
% This function compute the cosine similarity between two feature vectors
% input = vect1 and vect2
% Output  = Cosine similarity
s=0;
ss=0;
sss=0;
[nl,mc]=size(vect1);
for kk=1:(nl*mc)                             
    s=s+vect1(kk)*vect2(kk);                           
end
for h=1:(nl*mc)                                   
ss=ss+(vect1(h)*vect1(h));                             
end
ss=sqrt(ss);                                           
for h=1:(nl*mc)
sss=sss+(vect2(h)*vect2(h));                           
end
sss=sqrt(sss);                                         
similarity=(s/(ss*sss));                            
end