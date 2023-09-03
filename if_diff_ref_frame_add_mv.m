% Written by Natalia Molinero Mingorance

function [CandidateFrame,CandidateMv,Mvs,find_mv_refscomputations]=if_diff_ref_frame_add_mv(candidateR, candidateC, refFrame, usePrev,Mvs,CandidateMv,CandidateFrame,find_mv_refscomputations)

for j=1:2
   [CandidateFrame,CandidateMv,Mvs]  = get_block_mv(candidateR, candidateC, j, usePrev,Mvs,CandidateMv,CandidateFrame);
   find_mv_refscomputations=find_mv_refscomputations+1;
end
mvsSame=(CandidateMv{1,1}{1,1} == CandidateMv{1,2}{1,1}) && (CandidateMv{1,1}{1,2} == CandidateMv{1,2}{1,2});
if ( CandidateFrame{1}~=refFrame) %missing: && CandidateFrame(0)>INTRA_FRAME
    find_mv_refscomputations=scale_mv(1,refFrame,CandidateMv,find_mv_refscomputations); %not really needed for this example but useful to account for operations
%     add_mv_ref_list(0); not needed for this example
end
if CandidateFrame{2}~=refFrame
    if (mvsSame==0)% missing: && CandidateFrame(1)>INTRA_FRAME
        find_mv_refscomputations=scale_mv(2,refFrame,CandidateMv,find_mv_refscomputations);%not really needed for this example but useful to account for operations
%         add_mv_ref_list(1);not needed for this example
    end
end
end

