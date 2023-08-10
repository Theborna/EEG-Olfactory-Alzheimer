function MI = modulation_index(x, fs, bandwidth, num_bins)
    if nargin < 3
        bandwidth = [0.001 fs/2-0.001]; % Default to all-pass filtering
    end
    if nargin < 4
        num_bins = 18; % Default to 18 bins
    end
    
    numSignals = size(x, 1);
    MI = zeros(1, numSignals);

    for i = 1:numSignals
        signal = x(i,:,:);

        % Filtering the signal to the desired bandwidth
        filteredSignal = bandpass(signal, bandwidth, fs);

        % Calculate the analytic signal by applying the Hilbert transform
        analyticSignal = hilbert(filteredSignal);

        % Calculate the phase and amplitude of the analytic signal
        phase = angle(analyticSignal);
        amplitude = abs(analyticSignal);

        % Bin the phase values into the specified number of bins
        bins = linspace(-pi, pi, num_bins+1);
        phase_bins = discretize(phase, bins);

        % Convert phase_bins to numeric array
        phase_bins = double(phase_bins);

        % Calculate the average amplitude in each phase bin
        avg_amplitude = zeros(num_bins, 1);
        for j = 1:num_bins
            values = amplitude(phase_bins == j);
            if ~isempty(values)
                avg_amplitude(j) = mean(values);
            end
        end

        % Normalize the average amplitudes
        normalized_amplitude = avg_amplitude / sum(avg_amplitude);

        % Calculate the Shannon entropy
        entropy = -sum(normalized_amplitude .* log2(normalized_amplitude));

        % Calculate the Kullback-Leibler distance
        KL_distance = log2(num_bins) - entropy;

        % Calculate the modulation index
        MI(i) = KL_distance / log2(num_bins);
    end
end
