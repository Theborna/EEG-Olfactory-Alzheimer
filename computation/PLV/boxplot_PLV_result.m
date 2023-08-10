%% Ensure that the dimensions of the data matrices are compatible
num_AD = numel(mean_plv_frequent_AD);
num_Normal = numel(mean_plv_frequent_Normal);
max_num = max(num_AD, num_Normal);

% Pad the data matrices with NaN values to make their dimensions consistent
data_frequent_AD = [mean_plv_frequent_AD, NaN(1, max_num - num_AD)].';
data_frequent_Normal = [mean_plv_frequent_Normal, NaN(1, max_num - num_Normal)].';
data_rare_AD = [mean_plv_rare_AD, NaN(1, max_num - num_AD)].';
data_rare_Normal = [mean_plv_rare_Normal, NaN(1, max_num - num_Normal)].';

% Concatenate the data and group labels for all conditions
data = [data_frequent_AD, data_frequent_Normal,...
    data_rare_AD,data_rare_Normal];

% Create group labels for the boxplot
groupLabels = {'AD frequent', 'Normal frequent','AD rare', 'Normal rare'};

%% Plotting results
figure;
axes;

% Customize the boxplot
boxplot(data, groupLabels, 'Symbol', 'o', 'Widths', 0.5);

% Add a title and axis labels
title('Mean PLV of AD and Normal Patients');
xlabel('Patient Group');
ylabel('Mean PLV');

% Customize the axis limits and tick labels if desired
xlim([0.5, 4.5]);
ylim([0, max(data(:))*1.1]);
xticklabels(groupLabels);

% Customize the appearance of the plot
grid on;
box off;