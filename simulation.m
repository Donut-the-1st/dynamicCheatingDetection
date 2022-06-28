% Parameters
pFair     = 0.5;
pCheat    = 0.75;
targetFP  = 0.05;
targetFN  = 0.20;
numTests  = 10000;
numCheats = 5000;

% Set up
results = zeros(numTests, 4);

subjects = zeros(numTests, 1);
subjects(1:numCheats, 1) = pFair;
subjects(numCheats + 1:end, 1) = pCheat;

% Simulation
parfor i = 1:numTests
    [result, numPos, numNeg, numRepeats] = ...
        isCheating(subjects(i,1), pFair, pCheat, targetFP, targetFN)
    results(i,:) = [result, numPos, numNeg, numRepeats];
end

nonCheat = histogram(results(1:numCheats, 4));
hold on
cheats = histogram(results(numCheats + 1:end, 4));
nonCheat.Normalization = 'probability';
cheats.Normalization = 'probability';
nonCheat.BinWidth = 1;
cheats.BinWidth = 1;
legend()
hold off

numFalseAccused = sum(results(1:numCheats, 1));
numCheatFound = sum(results(numCheats + 1:end, 1));