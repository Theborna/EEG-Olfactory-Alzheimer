%% Load the data
load('..\..\data\AD.mat');  % Assuming the path is correct
load('..\..\data\Normal.mat');  % Assuming the path is correct

%% Set parameters
sampling_rate = 200;
bandwidth = [35 40];

%% Initialize variables
numADPatients = numel(AD); % Total number of AD patients
numNormalPatients = numel(normal); % Total number of Normal patients
numChannels = size(normal(1).epoch, 1);
mean_MI_rare_AD = zeros(numChannels, numADPatients);
mean_MI_frequent_AD = zeros(numChannels, numADPatients);
mean_MI_rare_Normal = zeros(numChannels, numNormalPatients);
mean_MI_frequent_Normal = zeros(numChannels, numNormalPatients);

%% Iterate over AD patients
for p = 1:numADPatients
    % Extract relevant data for the current AD patient
    person = AD(p);
    rare = person.epoch(:,:,logical(person.odor));
    frequent = person.epoch(:,:,~logical(person.odor));
    mean_rare = mean(rare, 3);
    mean_freq = mean(frequent, 3);
    % Calculate MI for rare trials
    mean_MI_rare_AD(:,p) = modulation_index(mean_rare, sampling_rate, bandwidth);
    % Calculate PLV for frequent trials
    mean_MI_frequent_AD(:,p) = modulation_index(mean_freq, sampling_rate, bandwidth);
end
%% Iterate over Normal patients
for p = 1:numNormalPatients
    % Extract relevant data for the current AD patient
    person = normal(p);
    rare = person.epoch(:,:,logical(person.odor));
    frequent = person.epoch(:,:,~logical(person.odor));
    mean_rare = mean(rare, 3);
    mean_freq = mean(frequent, 3);
    % Calculate MI for rare trials
    mean_MI_rare_Normal(:,p) = modulation_index(mean_rare, sampling_rate, bandwidth);
    % Calculate PLV for frequent trials
    mean_MI_frequent_Normal(:,p) = modulation_index(mean_freq, sampling_rate, bandwidth);
end
