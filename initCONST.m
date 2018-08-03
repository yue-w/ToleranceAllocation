function CONST = initCONST(BACH,PRICE, DIM, LTOL, UTOL, STEP,TAGUCH_K,KSIGMA,CONSTMETHOD,REWORK)
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
CONST.TAGUCH_K = TAGUCH_K;
CONST.KSIGMA = KSIGMA;
CONST.METHOD = CONSTMETHOD;
%Whether reworking parts with dimension larger than US.
CONST.REWORK = REWORK;
end