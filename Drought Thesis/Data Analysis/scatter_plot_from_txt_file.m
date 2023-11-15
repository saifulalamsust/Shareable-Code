% Set path to the folder containing the text files
folder_path = 'C:\Users\saifu\Desktop\Analysis\Result\Calibration\Monthly Average\';

% Define file names for observed and downscaled precipitation data
observed_file = 'Observed Data.txt';
downscaled_file = 'Raw GCM Data.txt';

% Import observed and downscaled precipitation data from text files
observed_data = dlmread(fullfile(folder_path, observed_file));
downscaled_data = dlmread(fullfile(folder_path, downscaled_file));

% Extract precipitation data from both files (column 1)
observed_precip = observed_data(:,1);
downscaled_precip = downscaled_data(:,1);

% Calculate Nash-Sutcliffe Efficiency (NSE) and R-squared
mean_observed = mean(observed_precip);
nse = 1 - sum((downscaled_precip - observed_precip).^2)./sum((observed_precip - mean_observed).^2);
r_squared = corr(observed_precip,downscaled_precip)^2;

% Plot scatter plot of observed vs. downscaled precipitation with NSE in title
figure;
scatter(observed_precip, downscaled_precip);
% set(gca, 'FontSize', 18); % Set font size of axes labels
xlabel('Observed Data (mm)', 'FontSize', 16);
ylabel('Raw GCM Data (mm)', 'FontSize', 14);
title(sprintf('NSE = %.4f, R^2 = %.4f', nse, r_squared), 'FontSize', 18); % Set font size of plot title