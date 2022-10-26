function [ s,f ] = svmdecision(samples,svmstruct)
sv=svmstruct.SupportVectors;
alpha=svmstruct.Alpha;
b=svmstruct.Bias;
kf=svmstruct.KernelFunction;
kfarg=svmstruct.KernelFunctionArgs;
scfact=svmstruct.ScaleData.scaleFactor;
scshift=svmstruct.ScaleData.shift;

for i= 1:size(samples,2);
    samples(:,i)=scfact(i)*(samples(:,i)+scshift(i));
end

f=-((feval(kf,sv,samples,kfarg{:})'*alpha(:))+b);
s=sign(f);

end

