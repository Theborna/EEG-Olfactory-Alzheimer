%% Ensure that the dimensions of the data matrices are compatible
num_AD = size(mean_MI_rare_AD,2);
num_Normal = size(mean_MI_rare_Normal,2);
max_num = max(num_AD, num_Normal);

% Pad the data matrices with NaN values to make their dimensions consistent
data_frequent_AD = [mean_MI_frequent_AD,...
    NaN(numChannels, max_num - num_AD)].';
data_frequent_Normal = [mean_MI_frequent_Normal,...
    NaN(numChannels, max_num - num_Normal)].';
data_rare_AD = [mean_MI_rare_AD,...
    NaN(numChannels, max_num - num_AD)].';
data_rare_Normal = [mean_MI_rare_Normal,...
    NaN(numChannels, max_num - num_Normal)].';

% Concatenate the data and group labels for all conditions
all_data = [data_frequent_AD, data_frequent_Normal,...
    data_rare_AD, data_rare_Normal];

% Create group labels for the boxplot
groupLabels = {'AD frequent', 'Normal frequent','AD rare', 'Normal rare'};

%% Plotting results
figure;
axes;
channels = {'Fp1', 'Fz', 'Cz', 'Pz'};
for i=1:numChannels
    cols = i + 0:numChannels:size(all_data,2);
    subplot(2,2,i)
    data = all_data(:,cols);
    boxplot(data, groupLabels, 'Symbol', 'o', 'Widths', 0.5);
    
    % Add a title and axis labels
    title('Mean MI of AD and Normal Patients');
    xlabel(sprintf('Channel: %s',channels{i}));
    ylabel('Mean MI');
    
    % Customize the axis limits and tick labels if desired
    xlim([0.5, 4.5]);
    ylim([0, max(data(:))*1.1]);
    xticklabels(groupLabels);
    
    % Customize the appearance of the plot
    grid on;
    box off;
end