clc;
import Coach.*

% Coach
COACH_ATTEMPTS = 1;

mancini = Coach();
mancini.setGenerationMode(Coach.GEN_MODE_RANDOM);
mancini.hiddenLayersRanges = [[10 200]; [7 80]; [5 10]];

for i=1:COACH_ATTEMPTS
    benchmark;
    % TODO Save net and performance
end
