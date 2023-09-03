% Written by Natalia Molinero Mingorance

function  [tFind_mv_refs, tFind_best_ref_mvs, tMv_selection, tMv_clamping, tMv_scaling, tBlock_inter, tInter_predicted_samples,computations, inter_predicted_samples] = predict_inter(plane, x, y, w, h , blockIdx)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%variables to measure computational complexity%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%times to compute each function:
tFind_mv_refs="";
tFind_best_ref_mvs="";
tMv_selection="";
tMv_clamping="";
tMv_scaling="";
tBlock_inter="";
tInter_predicted_samples="";


refList =1;
load('variables.mat')
NearestMv=cell(1,8);
NearMv=cell(1,8);
BestMv=cell(1,8);

tFind=tic;
[tFind_mv_refs,find_mv_refscomputations,candidateR,candidateC,RefListMv] = find_mv_refs(refFrame,block,MiRow,MiCol,Mvs,CandidateMv,CandidateFrame,MiSize);
tEndFind=toc(tFind)
computations=find_mv_refscomputations;

tFindBest=tic;
[tFind_best_ref_mvs,find_best_mv_refscomputations,NearestMv,NearMv,BestMv]=find_best_ref_mvs(refList,RefListMv,NearestMv,NearMv,BestMv);
tEndFindBest=toc(tFindBest)
computations=computations+find_best_mv_refscomputations;


Mvs(1)=Mv;
PrevMvs=Mvs;
for i=1:8
    if isempty(RefListMv{i})
        RefListMv{1,i}=["" ""];
    end
end

tMv=tic;
[tMv_selection,mv_selectioncomputations,Mv] = mv_selection(plane,refList,blockIdx, MiSize,subsampling_x,subsampling_y,RefListMv);
tEndMv_sel=toc(tMv)

computations=computations+mv_selectioncomputations;

sx=subsampling_x;
sy=subsampling_y;

tMvClam=tic;
[tMv_clamping,mv_clamplingcomputations,clampedMv] = mv_clamping(MiSize,sx,sy,Mv); 
tEndMvClam=toc(tMvClam)

computations=computations+mv_clamplingcomputations;

tMvScal=tic;
[tMv_scaling,mv_scalingcomputations,startX,startY,xStep,yStep] = mv_scaling(plane,x,y,clampedMv);
tEndMvScal=toc(tMvScal)

computations=computations+mv_scalingcomputations;
tInter_predicted_samples=tic;
tBlock=tic;
[tBlock_inter,block_intercomputations,pred] = block_inter(plane,x,y,xStep,yStep,w,h,subsampling_x,subsampling_y);
tEndBlock=toc(tBlock)

computations=computations+block_intercomputations;



inter_predicted_samples=pred;
tEndInter=toc(tInter_predicted_samples)
end

