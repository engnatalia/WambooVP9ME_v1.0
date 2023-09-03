% Written by Natalia Molinero Mingorance

function [value] = use_mv_hp(deltaMv)

COMPANDED_MVREF_THRESH=8;%Threshold	at	which	motion	vectors	are	considered	large
value = ( bitshift(abs( deltaMv(1) ), -3) < COMPANDED_MVREF_THRESH && bitshift(Abs(deltaMv(2)),-3) < COMPANDED_MVREF_THRESH); 
end

