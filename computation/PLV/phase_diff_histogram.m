% Load the data for normal and AD patients
load('../../data/Normal.mat');
load('../../data/AD.mat');

% Choose a random person from each group
people = {normal, AD};
names = {'Normal patient', 'AD patient'};
figure;

for i = 1:numel(people)
    group = people{i};

    % Preallocate arrays to store phase differences
    num_trials = numel(group) * size(group(1).epoch, 2);
    phaseDiff_freq = zeros(1, num_trials);
    phaseDiff_rare = zeros(1, num_trials);

    for j = 1:numel(group)
        person = group(j);

        % Extract rare and frequent trials
        rare = person.epoch(:, :, logical(person.odor));
        frequent = person.epoch(:, :, ~logical(person.odor));

        % Calculate mean of Fz_Cz for rare and frequent trials
        Fz_Cz_rare = mean(squeeze(rare(2:3, :, :)), 3);
        Fz_Cz_frequent = mean(squeeze(frequent(2:3, :, :)), 3);

        % Calculate phase differences using phase_diff function
        p = phase_diff(Fz_Cz_frequent(1,:), Fz_Cz_frequent(2,:));

        % Calculate index for storing phase differences
        idx = (j-1) * numel(p);

        % Store phase differences in respective arrays
        phaseDiff_freq((idx+1):(idx+numel(p))) = p;

        % Calculate phase differences for rare trials
        p = phase_diff(Fz_Cz_rare(1,:), Fz_Cz_rare(2,:));

        % Store phase differences in respective arrays
        phaseDiff_rare((idx+1):(idx+numel(p))) = p;
    end

    % Create subplots for phase histograms
    subplot(1, 2*numel(people), i);
    polarhistogram(phaseDiff_freq, 'Normalization', 'pdf');
    title('Phase Difference');
    subtitle(sprintf('%s (Frequent Trials)', names{i}));

    subplot(1, 2*numel(people), i + numel(people));
    polarhistogram(phaseDiff_rare, 'Normalization', 'pdf');
    title('Phase Difference');
    subtitle(sprintf('%s (Rare Trials)', names{i}));
end
