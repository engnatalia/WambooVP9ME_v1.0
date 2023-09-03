% Written by Natalia Molinero Mingorance

function [tFind_mv_refs,find_mv_refscomputations,candidateR,candidateC,RefListMv] = find_mv_refs(refFrame,block,MiRow,MiCol,Mvs,CandidateMv,CandidateFrame,MiSize)


load('variables.mat','mv_ref_blocks','RefFrames','ZeroMv','mode_2_counter','MVREF_NEIGHBOURS','UsePrevFrameMvs','MAX_MV_REF_CANDIDATES')
computations=0;
RefMvCount = 0;
differentRefFound = 0;
contextCounter = 0;
RefListMv=cell(1,8);
RefListMv{1} = ZeroMv;
RefListMv{2} = ZeroMv;
mv_ref_search = mv_ref_blocks(9); %9 means MiSize=BLOCK_32X32
for i=1:2
        tic
        candidateR= MiRow+mv_ref_search{1,1}{1,i}{1,1};
        candidateC= MiCol+mv_ref_search{1,1}{1,i}{1,2};
        computations=computations+1;
        tFind_mv_refs(computations+1)=toc;
    if is_inside(candidateR,candidateC) == 1  
        differentRefFound = 1;
        contextCounter=contextCounter+mode_2_counter(12);%12 is the index for y_mode ZeroMV, as in our example
        for j=1:2
            tic
            if RefFrames{1,j}==refFrame %RefFrames(candidateR,candidateC,j)==refFrame (we compare the first and the second one from the list in our example)
                %get_sub_block_mv(candidateR,candidateC,j,mv_ref_search{1,1}{1,i}{1,j},1);
                %%not needed for our example
                %add_mv_ref_list(j);%%not needed for our example
                computations=computations+1;
                tFind_mv_refs(computations+1)=toc;
                break
            end
        end
    end
end
for i=2:MVREF_NEIGHBOURS
        tic
        candidateR= MiRow+mv_ref_search{1,1}{1,i}{1,1};
        candidateC= MiCol+mv_ref_search{1,1}{1,i}{1,2};
        computations=computations+1;
        tFind_mv_refs(computations+1)=toc;
    if is_inside(candidateR,candidateC)== 1 
        differentRefFound = 1;
        tic
       [CandidateFrame,CandidateMv,Mvs,computations] = if_same_ref_frame_add_mv( candidateR, candidateC, refFrame, 0,Mvs,CandidateMv,CandidateFrame,computations);
        tFind_mv_refs(computations+1)=toc;
    end
end
if (UsePrevFrameMvs==1)
    tic
   [CandidateFrame,CandidateMv,Mvs,computations] = if_same_ref_frame_add_mv( MiRow, MiCol, refFrame, 1,Mvs,CandidateMv,CandidateFrame,computations);
   tFind_mv_refs(computations+1)=toc;
end

if ( differentRefFound ==1 )
    for i=1:MVREF_NEIGHBOURS
        tic
        candidateR= MiRow+mv_ref_search{1,1}{1,i}{1,1};
        candidateC= MiCol+mv_ref_search{1,1}{1,i}{1,2};
        tFind_mv_refs(computations+1)=toc;
        computations=computations+1;
            if is_inside(candidateR,candidateC)== 1
               tic
               [CandidateFrame,CandidateMv,Mvs,computations]= if_diff_ref_frame_add_mv( candidateR, candidateC, refFrame, 0 ,Mvs,CandidateMv,CandidateFrame,computations);
               tFind_mv_refs(computations+1)=toc;
            end
    end
end
if ( UsePrevFrameMvs==1 )
    tic
    [CandidateFrame,CandidateMv,Mvs,computations]=if_diff_ref_frame_add_mv( MiRow, MiCol, refFrame, 1,Mvs,CandidateMv,CandidateFrame,computations );
    tFind_mv_refs(computations+1)=toc;
end
% ModeContext(refFrame)=counter_to_context(contextCounter); %not needed for
% this example
for i=1:MAX_MV_REF_CANDIDATES
    tic
    RefListMv=clamp_mv_ref(i,RefListMv,MiSize);
    computations=computations+1;
    tFind_mv_refs(computations+1)=toc;
end
find_mv_refscomputations=computations;

