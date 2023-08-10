%% loading the data set
load ../../../data/Normal.mat
load ../Preprocess/Subject1.mat
subject1 = transpose(table2array(subject1));
load ../Preprocess/Subject2.mat
subject2 = transpose(table2array(subject2));
%% epoching the data
data = EEG.data;
sampling_rate = 200;
N = 120;
epoch = reshape(data(:,1:end-1), [19, floor(size(data,2)/N), N]);
epoch = epoch(:, 7*sampling_rate:10*sampling_rate - 1, :);
%% creating the struct
%% subject1
subject1_processed = struct();
data = EEG.data;
channels = [1,5,10,15];
subject1_processed.data = data(channels,:,:);
subject1_processed.noisy = [47,48,52,54,75,79,80,94,96,98];
subject1_processed.odor = normal(1).odor(1:size(data, 3));
%% subject2
subject2_processed = struct();
data = EEG.data;
channels = [1,5,10,15];
subject1_processed.data = data(channels,:,:);
subject1_processed.noisy = [1,2,115];
subject1_processed.odor = normal(1).odor(1:size(data, 3));