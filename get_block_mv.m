% Written by Natalia Molinero Mingorance

function [CandidateFrame,CandidateMv,Mvs] = get_block_mv(candidateR, candidateC, refList, usePrev,Mvs,CandidateMv,CandidateFrame)
%GET_BLOCK_MV Summary of this function goes here
%   Detailed explanation goes here
load('variables.mat','RefFrames')
if usePrev==1
    CandidateMv{refList} = PrevMvs{candidateR,candidateC,refList}; %it doesn't go here in our example
    CandidateFrame{refList} = PrevRefFrames{candidateR,candidateC,refList};
else
    Mvs{refList}={candidateR candidateC};
    CandidateMv{refList} = Mvs{refList}; %CandidateMv(refList) = Mvs(candidateR,candidateC,refList);
    CandidateFrame{refList} = RefFrames{refList};  
end
end

