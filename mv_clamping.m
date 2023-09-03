% Written by Natalia Molinero Mingorance

function [tMv_clamping,mv_clamplingcomputations,clampedMv] = mv_clamping(MiSize,sx,sy,mv)

load('variables.mat','num_8x8_blocks_high_lookup','MiRow','MiRows','MiCol','MiCols')
tic
mv_clamplingcomputations=0;
MI_SIZE=8; %Smallest	size	of	a	mode	info	block
INTERP_EXTEND=4; %Value	used	when	clipping	motion	vectors
SUBPEL_BITS=4; %Number	of	bits	of	precision	when	performing	inter	prediction
SUBPEL_SHIFTS=16; % means 1<<SUBPEL_BITS
bh = num_8x8_blocks_high_lookup{MiSize};
mbToTopEdge = -bitshift(((MiRow * MI_SIZE) * 16),-sy); 
mbToBottomEdge = bitshift(((MiRows - bh - MiRow) * MI_SIZE) * 16,-sy);
bw = num_8x8_blocks_high_lookup{MiSize};
mbToLeftEdge = -bitshift((MiCol * MI_SIZE) * 16,-sx);
mbToRightEdge = bitshift(((MiCols - bw - MiCol) * MI_SIZE) * 16,-sx);
spelLeft =bitshift(bitshift(INTERP_EXTEND + (bw * MI_SIZE), -sx), SUBPEL_BITS);
spelRight = spelLeft - SUBPEL_SHIFTS;
spelTop =bitshift(bitshift(INTERP_EXTEND + (bh * MI_SIZE), -sy), SUBPEL_BITS);
spelBottom = spelTop - SUBPEL_SHIFTS;
x=mbToTopEdge - spelTop;
y=mbToBottomEdge + spelBottom;
z=bitshift((2 * mv{1,1}(1)), -sy);
if z<x
    clampedMv(1)=x;
elseif z>y
    clampedMv(1)=y;
else
    clampedMv(1)=z;
end
x=mbToLeftEdge - spelLeft;
y=mbToRightEdge + spelRight;
z=bitshift((2 * mv{1,1}(2)), -sx);
if z<x
    clampedMv(2)=x;
elseif z>y
    clampedMv(2)=y;
else
    clampedMv(2)=z;
end
mv_clamplingcomputations=mv_clamplingcomputations+1;
tMv_clamping=toc;
end

