% Fitting a distribution
plv_rare_normal_dist = fitdist(mean_plv_rare_Normal', 'Normal');
plv_rare_AD_dist = fitdist(mean_plv_rare_AD', 'Normal');
plv_frequent_normal_dist = fitdist(mean_plv_frequent_Normal', 'Normal');
plv_frequent_AD_dist = fitdist(mean_plv_frequent_AD', 'Normal');
data = {mean_plv_rare_Normal, mean_plv_rare_AD, mean_plv_frequent_Normal, mean_plv_frequent_AD};

% Create a cell array of the fitted distributions
pdf_fit = {plv_rare_normal_dist, plv_rare_AD_dist, plv_frequent_normal_dist, plv_frequent_AD_dist};

names = {'PLV - Rare Stimulation (Normal)', 'PLV - Rare Stimulation (AD)', 'PLV - Frequent Stimulation (Normal)', 'PLV - Frequent Stimulation (AD)'};

%% Calculating significance of findings
% Perform a two-sample t-test
[~, p_rare] = ttest2(mean_plv_rare_Normal, mean_plv_rare_AD, 'Vartype', 'unequal');
[~, p_freq] = ttest2(mean_plv_frequent_Normal, mean_plv_frequent_AD, 'Vartype', 'unequal');
%% Plotting the fits
figure;
for i = 1:numel(pdf_fit)
    d = data{i};
    x = linspace(min(d), max(d), 100);
    y = pdf(pdf_fit{i}, x);
    subplot(2, 2, i);
    histogram(d, 6, 'Normalization', 'pdf', 'FaceColor', [0.7 0.7 0.7]);
    hold on;
    plot(x, y, 'LineWidth', 2);
    hold off;
    title(names{i});
    xlabel('PLV');
    ylabel('Probability Density');
    legend('Data', 'Fitted Distribution');
end

%% Save results to file
outputFilePath = 'result/statistical_analysis.txt';
fileID = fopen(outputFilePath, 'w');

fprintf(fileID, 'Fitting a normal distribution\n');
fprintf(fileID, '----------------------------------\n');
fprintf(fileID, '\n');

for i = 1:numel(pdf_fit)
    dist = pdf_fit{i};
    fprintf(fileID, 'Distribution: %d\n', i);
    fprintf(fileID, 'Name: %s\n', names{i});
    fprintf(fileID, 'Type: %s\n', dist.DistributionName);
    fprintf(fileID, 'Parameters: %s\n', num2str(dist.ParameterValues));
    fprintf(fileID, '----------------------------------\n');
    fprintf(fileID, '\n');
end

fprintf(fileID, 'P-values\n');
fprintf(fileID, '----------------------------------\n');
fprintf(fileID, 'P-value - Rare Stimulation: %f\n', p_rare);
fprintf(fileID, 'P-value - Frequent Stimulation: %f\n', p_freq);

fclose(fileID);