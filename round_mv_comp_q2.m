% Written by Natalia Molinero Mingorance

function [rounded] = round_mv_comp_q2(value)

value= str2double(value);
if value<0
    rounded=(value-1)/2;
else
    rounded=(value+1)/2;
end
end

