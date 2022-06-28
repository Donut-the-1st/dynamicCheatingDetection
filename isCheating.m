function [result, numPos, numNeg, numRepeats] = isCheating(pSubject, pFair, pCheat, targetFP, targetFN) %#codegen
%ISCHEATING Tests to see if the subject is cheating
%   Repeatedly gets the subject to do a random event until we are less than
%   targetFP chance of falsely accusing them of cheating, and have a less
%   than targetFN chance of letting them get away with it, subject to
%   global pFair, Chance of event given they are not cheating, global 
%   pCheat the expected chance of the event if they are cheating, and 
%   pSubject, the real chance of this subject having the event occor

% Outputs
numPos = 0;
numNeg = 0;
numRepeats = 0;
result = false;

% Simulation
while true
    % Flip Coin
    if rand() >= pSubject
        numPos = numPos + 1;        
    else
        numNeg = numNeg + 1;
    end
    numRepeats = numRepeats + 1;
    
    % Check if positive
    result = binocdf(numPos - 1, numRepeats, pFair, 'upper') <= targetFP;
    if result
        return
    end

    % Check if negative
    result = binocdf(numPos, numRepeats, pCheat) <= targetFN;
    if result
        result = false;
        return
    end
end

end