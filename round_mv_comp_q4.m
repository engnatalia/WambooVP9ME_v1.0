% Written by Natalia Molinero Mingorance

function [rounded] = round_mv_comp_q4(value)

value= str2double(value);
if value<0
    rounded=(value-2)/4;
else
    rounded=(value+2)/4;
end
end

