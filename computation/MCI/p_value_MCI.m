%% Calculating significance of findings
% Perform a two-sample t-test for rare normal vs. rare MCI
[~, p_rare_normal_mci] = ttest2(mean_plv_rare_Normal, mean_plv_rare_MCI, 'Vartype', 'unequal');

% Perform a two-sample t-test for frequent normal vs. frequent MCI
[~, p_freq_normal_mci] = ttest2(mean_plv_frequent_Normal, mean_plv_frequent_MCI, 'Vartype', 'unequal');

% Perform a two-sample t-test for rare AD vs. rare MCI
[~, p_rare_ad_mci] = ttest2(mean_plv_rare_AD, mean_plv_rare_MCI, 'Vartype', 'unequal');

% Perform a two-sample t-test for frequent AD vs. frequent MCI
[~, p_freq_ad_mci] = ttest2(mean_plv_frequent_AD, mean_plv_frequent_MCI, 'Vartype', 'unequal');

%% Save results to file
outputFilePath = 'results/p_value.txt';
fileID = fopen(outputFilePath, 'w');

fprintf(fileID, 'P-values\n');
fprintf(fileID, '----------------------------------\n');
fprintf(fileID, 'P-value - Rare Normal vs. Rare MCI: %f\n', p_rare_normal_mci);
fprintf(fileID, 'P-value - Frequent Normal vs. Frequent MCI: %f\n', p_freq_normal_mci);
fprintf(fileID, 'P-value - Rare AD vs. Rare MCI: %f\n', p_rare_ad_mci);
fprintf(fileID, 'P-value - Frequent AD vs. Frequent MCI: %f\n', p_freq_ad_mci);

fclose(fileID);
