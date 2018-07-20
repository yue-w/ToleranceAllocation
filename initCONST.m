function CONST = initCONST(BACH,PRICE, DIM, LTOL, UTOL, STEP)
%BACH is the number of parts simulated to be machined
CONST.BACH = BACH;
CONST.PRICE = PRICE;
%Designed dimension of the product
CONST.DIM = DIM;
%Lower Tollerance to be allocated
CONST.LTOL = LTOL;
%Upper tolerance to be allocated
CONST.UTOL = UTOL;

CONST.STEP = STEP;
end