% Written by Natalia Molinero Mingorance

function [tMv_scaling,mv_scalingcomputations,startX,startY,stepX,stepY] = mv_scaling(plane,x,y,clampedMv)


mv_scalingcomputations=0;
load('variables.mat','ref_frame')
tic
[row, col] = size(ref_frame);
REF_SCALE_SHIFT=14; %Number	of	bits	of	precision	when	scaling	reference	frames
SUBPEL_MASK=15; %SUBPEL_SHIFTS	- 1
SUBPEL_BITS=4;%Number	of	bits	of	precision	when	performing	inter	prediction
%refIdx=ref_frame_idx(ref_frame(refList) - LAST_FRAME); ---> not needed in
%our example because we use refIdx=1


xScale=bitshift(row,REF_SCALE_SHIFT)/row; % xScale=bitshift(RefFrameWidth(refIdx),-REF_SCALE_SHIFT)/FrameWidth;
yScale=bitshift(col,REF_SCALE_SHIFT)/col; % yScale=bitshift(RefFrameHeight(refIdx),-REF_SCALE_SHIFT)/FrameHeight;
baseX=bitshift(x*xScale,-REF_SCALE_SHIFT);
baseY=bitshift(y*yScale,-REF_SCALE_SHIFT);

% lumaX= (plane > 0) ? x << subsampling_x : x
if plane>0 
    lumaX=bitshift(x,subsampling_x);
else
    lumaX=x;
end

% lumaY= (plane > 0) ? y << subsampling_y : y
if plane>0 
    lumaY=bitshift(y,subsampling_y);
else
    lumaY=y;
end

fracX=bitshift(16 * lumaX * xScale, -REF_SCALE_SHIFT) & SUBPEL_MASK;
fracY=bitshift(16 * lumaY * yScale, -REF_SCALE_SHIFT) & SUBPEL_MASK;
dX=bitshift(clampedMv(2) * xScale,-REF_SCALE_SHIFT)+ fracX;
dY=bitshift(clampedMv(1) * yScale,-REF_SCALE_SHIFT)+ fracY;
stepX=bitshift(16 * xScale,-REF_SCALE_SHIFT);
stepY=bitshift(16 * yScale,-REF_SCALE_SHIFT);
startX = bitshift(baseX,SUBPEL_BITS)+dX;
startY = bitshift(baseY,SUBPEL_BITS)+dY;
mv_scalingcomputations=mv_scalingcomputations+1;
tMv_scaling=toc;
end

