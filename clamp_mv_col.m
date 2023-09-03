% Written by Natalia Molinero Mingorance

function [value] = clamp_mv_col(mvec,border,MiSize)

load('variables.mat','num_8x8_blocks_high_lookup','MiCol','MiCols')
MI_SIZE=8; %Smallest	size	of	a	mode	info	block
bw = num_8x8_blocks_high_lookup{MiSize};
mbToLeftEdge = -((MiCol * MI_SIZE) * 8);
mbToRightEdge = ((MiCols - bw - MiCol) * MI_SIZE) * 8;
if mvec<(mbToLeftEdge -border)
    value = mbToLeftEdge -border;
elseif mvec>(mbToRightEdge +border)
    value = mbToRightEdge +border;
else
    value=mvec;
end
