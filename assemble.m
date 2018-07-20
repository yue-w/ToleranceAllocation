function productDim = assemble(partDims)
%{
Compute the dimension of the products randomly assembled by these parts.
Support nonlinear relationships
%}
    productDim = sum(partDims,1);
end