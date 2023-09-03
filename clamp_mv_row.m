% Written by Natalia Molinero Mingorance

function [value] = clamp_mv_row( mvec, border,MiSize)

load('variables.mat','num_8x8_blocks_high_lookup','MiRow','MiRows')
MI_SIZE=8; %Smallest	size	of	a	mode	info	block
bh = num_8x8_blocks_high_lookup{MiSize};
mbToTopEdge = -((MiRow * MI_SIZE) * 8);
mbToBottomEdge = ((MiRows - bh - MiRow) * MI_SIZE) * 8;
if mvec<(mbToTopEdge -border)
    value = mbToTopEdge -border;
elseif mvec>(mbToBottomEdge +border)
    value = mbToBottomEdge +border;
else
    value=mvec;
end

