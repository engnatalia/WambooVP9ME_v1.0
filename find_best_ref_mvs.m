% Written by Natalia Molinero Mingorance

function [tFind_best_ref_mvs,find_best_mv_refscomputations,NearestMv,NearMv,BestMv]=find_best_ref_mvs(refList,RefListMv,NearestMv,NearMv,BestMv)
computations=0;
BORDERINPIXELS=160;%Value	used when clipping motion vectors
INTERP_EXTEND=4; %Value	used when clipping motion vectors
load('variables.mat','MiSize')
allow_high_precision_mv=0;%motion vectors are specified to quarter pel precision
for i=1:2 %MAX_MV_REF_CANDIDATES
    tic
    deltaRow=RefListMv{1,i}(1);
    deltaCol=RefListMv{1,i}(2);
    if (allow_high_precision_mv == 0 || use_mv_hp(RefListMv{1,i})==0)
        if deltaRow & 1 
            if deltaRow>0
                deltaRow=deltaRow-1;
            else
                deltaRow=deltaRow+1;
            end
        end
        if deltaCol & 1 
            if deltaCol>0
                deltaCol=deltaCol-1;
            else
                deltaCol=deltaCol+1;
            end
        end
    end
    RefListMv{1,i}(1)=clamp_mv_row(deltaRow,bitshift((BORDERINPIXELS - INTERP_EXTEND), 3),MiSize); 
    RefListMv{1,i}(2)=clamp_mv_col(deltaCol,bitshift((BORDERINPIXELS - INTERP_EXTEND), 3),MiSize); 
    computations=computations+1;
    tFind_best_ref_mvs(computations+1)=toc;
end
NearestMv(refList) = RefListMv(1);
NearMv(refList) = RefListMv(2);
BestMv(refList) = RefListMv(1); 
find_best_mv_refscomputations=computations;
end

