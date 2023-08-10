function plv = PLV(signals1, signals2, fs, bandwidth)
    if nargin < 4
        bandwidth = [0.001 fs/2-0.001]; % Default to all-pass filtering
    end
    
    numSignals = size(signals1, 3);
    plv = zeros(1, numSignals);
    
    for i = 1:numSignals
        signal1 = signals1(:,:,i);
        signal2 = signals2(:,:,i);

        % filtering the signal to the desired bandwidth
        filteredSignal1 = bandpass(signal1, bandwidth, fs);
        filteredSignal2 = bandpass(signal2, bandwidth, fs);
        
        % calculating phase difference
        phaseDiff = phase_diff(filteredSignal1, filteredSignal2);

        % Calculate the PLV
        plv(i) = abs(mean(exp(1j * phaseDiff)));
    end
end
