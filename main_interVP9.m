% Written by Natalia Molinero Mingorance
clc
close all
clear all
clearAllMemoizedCaches


load('variables.mat')
plane = block; %this is an index

x =1;
y =1;
blockIdx=1;
errors=0;
memUsed
tStartME=tic;
[tFind_mv_refs, tFind_best_ref_mvs, tMv_selection, tMv_clamping, tMv_scaling, tBlock_inter, tInter_predicted_samples,computations, inter_predicted_samples] = predict_inter(plane, x, y, w, h , blockIdx);
tEndME=toc(tStartME)
[w,h]=size(inter_predicted_samples);

% for x=1:w
%     for i=1:h
%         if inter_predicted_samples(x,i)~=0
%             errors=errors+1;
%             computations=computations+1;
%         end
%     end
% end
% error=errors/(w*h);
psnr = imgPSNR(target_frame, inter_predicted_samples, 255);

%kWh = (watts × hrs) ÷ 1,000
%averaged watts measured during execution: 5.1W
%execution time in hrs:
tEndME=tEndME/3600;
E=5.1*tEndME/1000;
C=E*.16;
%operational emissions= E*I
I=275; %carbon intensity in Europe in 2021
O=E*I;
memUsed

