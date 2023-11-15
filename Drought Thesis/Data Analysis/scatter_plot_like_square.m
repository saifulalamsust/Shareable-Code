% Set path to the folder containing the text files
folder_path = 'C:\Users\saifu\Desktop\Analysis\Result\Validation\Monthly Average';

% Define file names for observed and downscaled precipitation data
observed_file = 'Observed Data.txt';
downscaled_file = 'Bias corrected Downscaled Data.txt';

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

% Plot scatter plot of observed vs. downscaled precipitation with NSE and MSE in title
figure;
scatter(observed_precip, downscaled_precip, 150, 's', 'filled', 'MarkerFaceColor', 'g'); % Large square-shaped data points
hold on; % Hold the plot
x = linspace(min(observed_precip), max(observed_precip), 100);
y = x; % Diagonal line
plot(x, y, 'r--', 'LineWidth', 1); % Add diagonal line
set(gca, 'FontSize', 12); % Set font size of axes labels
xlabel('Observed Data (mm)', 'FontSize', 16);
ylabel('Bias corrected Downscaled Data (mm)', 'FontSize', 16);
title(sprintf('NSE = %.4f, R^2 = %.4f, MSE = %.4f', nse, r_squared, mean((downscaled_precip - observed_precip).^2)), 'FontSize', 16); % Set font size of plot title
grid on; % Add grid to the plot
legend('Data', 'Diagonal line', 'Location', 'northwest'); % Add legend