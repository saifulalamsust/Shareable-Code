% Specify the location of the Excel file
file = 'C:\Users\saifu\Desktop\Analysis\SPEI\data_1.xlsx';

% Read in the data from the Excel file
data = readmatrix(file, 'NumHeaderLines', 1); % assuming variable names are in row 1

% Extract the SPI and SPEI values
spi_1 = data(:, 1);
spi_2 = data(:, 3);
spei_1 = data(:, 2);
spei_2 = data(:, 4);


% Create a bar chart for the SPI and SPEI values
bar([spi_1, spei_1, spi_2, spei_2], 'FaceColor', 'flat');
colormap(gca, [1 1 1; 0.5 0.5 0.5]); % set the colors for SPI and SPEI bars
xlabel('Year', 'FontSize', 18);
ylabel('Value', 'FontSize', 18);
title('SPI and SPEI Values(SSP245)', 'FontSize', 18);

% Show only year labels for every 5 years
xticks(1:5:length(spi_1));
xticklabels(string(2023:5:2052));
legend('SPEI', 'SPI');
grid on;
% Calculate the p-value and correlation coefficient for spi_1 and spei_1
[rho1, pval1] = corr(spi_1, spei_1);

% Calculate the p-value and correlation coefficient for spi_2 and spei_2
[rho2, pval2] = corr(spi_2, spei_2);

% Calculate the p-value and correlation coefficient for spi_1 and spei_1
[rho1, pval1] = corr(spi_1, spei_1);
% Add text boxes with p-value and correlation coefficient
text(0.7, max(max([spi_1, spei_1, spi_2, spei_2]))*0.95, ['\rho = ' num2str(rho1) ', p = ' num2str(pval1)], 'FontSize', 14, 'Units', 'normalized');
text(0.7, max(max([spi_1, spei_1, spi_2, spei_2]))*0.9, ['\rho = ' num2str(rho2) ', p = ' num2str(pval2)], 'FontSize', 14, 'Units', 'normalized');

% Add additional text to the plot
text(0.05, 0.95, 'r= 0.23, p>0.05', 'FontSize', 15, 'Units', 'normalized');