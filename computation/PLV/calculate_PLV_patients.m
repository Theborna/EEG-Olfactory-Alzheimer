%% Load the data
load('..\..\data\AD.mat');  % Assuming the path is correct
load('..\..\data\Normal.mat');  % Assuming the path is correct

%% Set parameters
sampling_rate = 200;
bandwidth = [35 40];

%% Initialize variables
numADPatients = numel(AD); % Total number of AD patients
numNormalPatients = numel(normal); % Total number of Normal patients
mean_plv_rare_AD = zeros(1, numADPatients);
mean_plv_frequent_AD = zeros(1, numADPatients);
mean_plv_rare_Normal = zeros(1, numNormalPatients);
mean_plv_frequent_Normal = zeros(1, numNormalPatients);

%% Iterate over AD patients
for p = 1:numADPatients
    % Extract relevant data for the current AD patient
    person = AD(p);
    rare = person.epoch(:,:,logical(person.odor));
    frequent = person.epoch(:,:,~logical(person.odor));
    Fz_Cz_rare = squeeze(rare(2:3,:,:));
    Fz_Cz_frequent = squeeze(frequent(2:3,:,:));

    % Calculate PLV for rare trials
    Fz_mean = mean(Fz_Cz_rare(1,:,:),3);
    Cz_mean = mean(Fz_Cz_rare(2,:,:),3);
    mean_plv_rare_AD(p) = PLV(Fz_mean,Cz_mean,sampling_rate,bandwidth);

    % Calculate PLV for frequent trials
    Fz_mean = mean(Fz_Cz_frequent(1,:,:),3);
    Cz_mean = mean(Fz_Cz_frequent(2,:,:),3);
    mean_plv_frequent_AD(p) = PLV(Fz_mean,Cz_mean,sampling_rate,bandwidth);
end

%% Iterate over Normal patients
for p = 1:numNormalPatients
    % Extract relevant data for the current Normal patient
    person = normal(p);
    rare = person.epoch(:,:,logical(person.odor));
    frequent = person.epoch(:,:,~logical(person.odor));
    Fz_Cz_rare = squeeze(rare(2:3,:,:));
    Fz_Cz_frequent = squeeze(frequent(2:3,:,:));

    % Calculate PLV for rare trials
    Fz_mean = mean(Fz_Cz_rare(1,:,:),3);
    Cz_mean = mean(Fz_Cz_rare(2,:,:),3);
    mean_plv_rare_Normal(p) = PLV(Fz_mean,Cz_mean,sampling_rate,bandwidth);

    % Calculate PLV for frequent trials
    Fz_mean = mean(Fz_Cz_frequent(1,:,:),3);
    Cz_mean = mean(Fz_Cz_frequent(2,:,:),3);
    mean_plv_frequent_Normal(p) = PLV(Fz_mean,Cz_mean,sampling_rate,bandwidth);
end
