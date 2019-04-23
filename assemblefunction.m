function productDim=assemblefunction(partDims)
[m,~] = size(partDims);
if m == 4
    tem = (partDims(2,:)+partDims(3,:))/2;
    cosV = (partDims(1,:)+tem)./(partDims(4,:)-tem);
    cosV = cosV(cosV>=-1 & cosV<=1);
    productDim = acos(cosV);
elseif m==3
    cosV = (partDims(1,:) + partDims(2,:))./(partDims(3,:)-partDims(2,:));
    cosV = cosV(cosV>=-1 & cosV<=1);
    productDim = acos(cosV);    
    
end