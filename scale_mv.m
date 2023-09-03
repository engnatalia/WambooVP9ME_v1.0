% Written by Natalia Molinero Mingorance

function find_mv_refscomputations=scale_mv(refList, refFrame,CandidateMv,find_mv_refscomputations)

candFrame = CandidateFrame(refList);
ref_frame_sign_bias=[0,0,0,0];
% if ref_frame_sign_bias(candFrame) ~= ref_frame_sign_bias(refFrame)
% %missing so we assume they have the same sign
    for j=1:2
        
        CandidateMv{refList,j}=CandidateMv{refList,j}*(-1);
        find_mv_refscomputations=find_mv_refscomputations+1;
    end
% end
end

