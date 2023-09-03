% Written by Natalia Molinero Mingorance

function [RefListMv] = clamp_mv_ref(i,RefListMv,MiSize)


MV_BORDER=128; %Value	used	when	clipping	motion vectors
RefListMv{1,i} = [clamp_mv_row( RefListMv{1,i}{1,1}, MV_BORDER,MiSize ), clamp_mv_col( RefListMv{1,i}{1,2}, MV_BORDER,MiSize )];
   
end

