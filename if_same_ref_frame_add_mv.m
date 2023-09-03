% Written by Natalia Molinero Mingorance

function [CandidateFrame,CandidateMv,Mvs,find_mv_refscomputations] =if_same_ref_frame_add_mv( candidateR, candidateC, refFrame, usePrev,Mvs,CandidateMv,CandidateFrame,find_mv_refscomputations )

for j=1:2
    [CandidateFrame,CandidateMv,Mvs] =get_block_mv(candidateR, candidateC, j, usePrev,Mvs,CandidateMv,CandidateFrame);
    find_mv_refscomputations=find_mv_refscomputations+1;
%not needed for our example
%     if CandidateFrame{1,j}==refFrame
%         add_mv_ref_list(j);
%     end
end

