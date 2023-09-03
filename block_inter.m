% Written by Natalia Molinero Mingorance

function [tBlock_inter,block_intercomputations,pred] = block_inter(plane,x,y,xStep,yStep,w,h,subsampling_x,subsampling_y)
computations=0;
load('variables.mat','ref_frame','subpel_filters','interpolation_filter')
[RefFrameWidth, RefFrameHeight] = size(ref_frame);
if plane == 0
    subX=0;
    subY=0;
else
    subX=subsampling_x;
    subY=subsampling_y;
end
lastX= bitshift((RefFrameWidth + subX), -subX) - 1;
lastY= bitshift((RefFrameHeight + subY), -subY) - 1;
intermediateHeight= bitshift(((h -1) * yStep + 15) , -4) + 8;

for r=1:intermediateHeight
    tic
    for c=1:w
        s=0;
        p = x + xStep * c;
        tic
        for t=1:8
            tic
            if (bitshift(y,-4)+r-3)<0
                a=0;
            elseif (bitshift(y,-4)+r-3)>lastY
                a=lastY;
            else 
                a=(bitshift(y,-4)+r-3);
            end
            if (bitshift(p,-4)+t-3)<0
                b=0;
            elseif (bitshift(p,-4)+t-3)>lastX
                b=lastX;
            else 
                b=(bitshift(p,-4)+t-3);
            end
            s=s+subpel_filters{interpolation_filter,1}{p & 15}{1,t}.*ref_frame.*a.*b;
            tBlock_inter(computations+1)=toc;
            computations=computations+1;
        end
        round=bitshift(int8(s+bitshift(1,(7-1))),-7);
        if round<0
            intermediate(r,c)=0;
        elseif round>bitshift(1,8)-1
            intermediate(r,c)=bitshift(1,8)-1;
        else 
            intermediate(r,c)=round(r,c);
        end
        tBlock_inter(computations+1)=toc;
        computations=computations+1;
    end
    tBlock_inter(computations+1)=toc;
    computations=computations+1;
end

for r=1:h
    tic
    for c=1:w
        s=0;
        p=(y&15)+yStep*r;
            tic
            for t=1:8-1
                tic
                s=s+subpel_filters{interpolation_filter,1}{p & 15}{1,t}.*intermediate(bitshift(p,-4)+t,c);
                tBlock_inter(computations+1)=toc;
                computations=computations+1;
            end
            round=bitshift(s+bitshift(1,(7-1)),-7);
            if round<0
                pred(r,c)=0;
            elseif round>bitshift(1,8)-1
                pred(r,c)=bitshift(1,8)-1;
            else 
                pred(r,c)=round;
            end
    end
    tBlock_inter(computations+1)=toc;
    computations=computations+1;
end
block_intercomputations=computations;
