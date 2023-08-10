% Load the data for AD and Normal patients
load('../../data/AD.mat');
load('../../data/Normal.mat');

% Set parameters
sampling_rate = 200;
bandwidth = [35 40];

% Initialize variables
numADPatients = numel(AD); % Total number of AD patients
numNormalPatients = numel(normal); % Total number of Normal patients
numChannel = size(AD(1).epoch, 1);

% Initialize PLV matrices for Normal and AD patients
plv_freq_normal = zeros(numChannel, numChannel);
plv_rare_normal = zeros(numChannel, numChannel);
plv_freq_AD = zeros(numChannel, numChannel);
plv_rare_AD = zeros(numChannel, numChannel);

% Calculate average PLV across all Normal patients
for personIndex = 1:numel(normal)
    person = normal(personIndex);
    rare = person.epoch(:,:,logical(person.odor));
    frequent = person.epoch(:,:,~logical(person.odor));
    
    % Calculate the mean across trials
    mean_rare = mean(rare, 3);
    mean_frequent = mean(frequent, 3);
    
    % Calculate PLV between each channel for Normal patients
    plv_freq_idx = zeros(numChannel, numChannel);
    plv_rare_idx = zeros(numChannel, numChannel);

    % Calculate PLV between each channel
    for i = 1:numChannel
        for j = i+1:numChannel
            plv_freq_idx(i,j) = PLV(mean_frequent(i,:),...
                mean_frequent(j,:), sampling_rate, bandwidth);
            plv_rare_idx(i,j) = PLV(mean_rare(i,:),...
                mean_rare(j,:), sampling_rate, bandwidth);
        end
    end
    
    % Fill in the lower triangle of the PLV matrices
    plv_freq_idx = plv_freq_idx + tril(plv_freq_idx', -1) + eye(numChannel);
    plv_rare_idx = plv_rare_idx + tril(plv_rare_idx', -1) + eye(numChannel);

    % Accumulate PLV values for Normal patients
    plv_freq_normal = plv_freq_normal + plv_freq_idx;
    plv_rare_normal = plv_rare_normal + plv_rare_idx;
end

% Divide by the total number of Normal patients to obtain the average PLV
plv_freq_normal = plv_freq_normal / numel(normal);
plv_rare_normal = plv_rare_normal / numel(normal);

% Calculate average PLV across all AD patients
for personIndex = 1:numel(AD)
    person = AD(personIndex);
    rare = person.epoch(:,:,logical(person.odor));
    frequent = person.epoch(:,:,~logical(person.odor));
    
    % Calculate the mean across trials
    mean_rare = mean(rare, 3);
    mean_frequent = mean(frequent, 3);
    
    % Calculate PLV between each channel for AD patients
    plv_freq_idx = zeros(numChannel, numChannel);
    plv_rare_idx = zeros(numChannel, numChannel);

    % Calculate PLV between each channel
    for i = 1:numChannel
        for j = i+1:numChannel
            plv_freq_idx(i,j) = PLV(mean_frequent(i,:),...
                mean_frequent(j,:), sampling_rate, bandwidth);
            plv_rare_idx(i,j) = PLV(mean_rare(i,:),...
                mean_rare(j,:), sampling_rate, bandwidth);
        end
    end
    
    % Fill in the lower triangle of the PLV matrices
    plv_freq_idx = plv_freq_idx + tril(plv_freq_idx', -1) + eye(numChannel);
    plv_rare_idx = plv_rare_idx + tril(plv_rare_idx', -1) + eye(numChannel);

    % Accumulate PLV values for AD patients
    plv_freq_AD = plv_freq_AD + plv_freq_idx;
    plv_rare_AD = plv_rare_AD + plv_rare_idx;
end

% Divide by the total number of AD patients to obtain the average PLV
plv_freq_AD = plv_freq_AD / numel(AD);
plv_rare_AD = plv_rare_AD / numel(AD);
%% ploti
% Define channel names
channelNames = {'Fp1', 'Fz', 'Cz', 'Pz'};

% Create a subplot with six heatmaps for Normal and AD patients
figure('Name', 'Average PLV Matrix');
sgtitle('Average PLV Matrix');



% Subplot 1: Average PLV Matrix - Normal (Frequent Odor)
plotHeatmap(plv_freq_normal, 'Normal (Frequent Odor)', 1, numChannel, channelNames);

% Subplot 2: Average PLV Matrix - AD (Frequent Odor)
plotHeatmap(plv_freq_AD, 'AD (Frequent Odor)', 2, numChannel, channelNames);

% Calculate the difference matrix between AD and Normal patients (Frequent Odor)
plv_freq_diff = abs(plv_freq_AD - plv_freq_normal);

% Display the difference matrix (Frequent Odor)
plotHeatmap(plv_freq_diff, 'Difference Matrix (Frequent Odor)', 3, numChannel, channelNames);

% Subplot 4: Average PLV Matrix - Normal (Rare Odor)
plotHeatmap(plv_rare_normal, 'Normal (Rare Odor)', 4, numChannel, channelNames);

% Subplot 5: Average PLV Matrix - AD (Rare Odor)
plotHeatmap(plv_rare_AD, 'AD (Rare Odor)', 5, numChannel, channelNames);

% Calculate the difference matrix between AD and Normal patients (Rare Odor)
plv_rare_diff = abs(plv_rare_AD - plv_rare_normal);

% Display the difference matrix (Rare Odor)
plotHeatmap(plv_rare_diff, 'Difference Matrix (Rare Odor)', 6, numChannel, channelNames);

% Plotting function
function plotHeatmap(matrix, titleStr, subplotIndex, numChannel, channelNames) 
    subplot(2, 3, subplotIndex);
    imagesc(matrix);
    colorbar;
    title(titleStr);
    xlabel('Channel');
    ylabel('Channel');
    xticks(1:numChannel);
    yticks(1:numChannel);
    xticklabels(channelNames);
    yticklabels(channelNames);
end