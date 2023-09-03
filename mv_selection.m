% Written by Natalia Molinero Mingorance

function [tMv_selection,mv_selectioncomputations,mv] = mv_selection(plane,refList,blockIdx, MiSize,subsampling_x,subsampling_y,BlockMvs)
computations=0;
tic
mv="";
if all(plane == 0,'all')  || MiSize >=16
    mv=BlockMvs(refList, blockIdx);
elseif subsampling_x==0 && subsampling_y==0 
    mv=BlockMvs(refList, blockIdx);
elseif subsampling_x==0 && subsampling_y==1 
    for comp=0:1
        tic
        mv(comp)=round_mv_comp_q2( BlockMvs{refList, blockIdx}(comp) + BlockMvs{refList, blockIdx + 1}(comp) );
        mv= str2double(mv);
        tMv_selection(computations+1)=toc;
        computations=computations+1;
    end
elseif subsampling_x==1 && subsampling_y==1 
    for comp=1:2
        tic
        mv(comp)=round_mv_comp_q4( BlockMvs{refList, 1}(comp) + BlockMvs{refList, 2}(comp)+ BlockMvs{refList, 3}(comp) + BlockMvs{refList, 4}(comp) );
        mv= str2double(mv);
        computations=computations+1;
        tMv_selection(computations+1)=toc;
    end
end
tMv_selection(computations+1)=toc;
mv_selectioncomputations=computations;
end

