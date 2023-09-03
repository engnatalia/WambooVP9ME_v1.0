% Written by Natalia Molinero Mingorance

function [result] = is_inside(candidateR,candidateC)
load('variables.mat','MiRows');
result=0;
MiColStart=1;%%we should compute MiColStart = get_tile_offset( tileCol, MiCols, tile_cols_log2 )

MiColEnd=257;%%we should compute MiColEnd = get_tile_offset( tileCol + 1, MiCols, tile_cols_log2 )
for i=1:length(candidateR)
    if (candidateR(i)>=0 && candidateR(i)<MiRows && candidateC(i) >= MiColStart && candidateC(i) < MiColEnd)==1
        result=1;
    end
end
end

