% Specify the name of the CSV file and worksheet
filename = 'C:\Users\saifu\Desktop\Analysis\Result\Validation\Monthly Average\Data_file_1.csv';

% Read the data from the CSV file
data = readmatrix(filename);

% Extract the precipitation data from the remaining columns of the data matrix
ylevel = data(:,2:end);

% Get the column names from the CSV file as legend labels
legend_labels = textread(filename,'%s',1,'delimiter','\n');
legend_labels = split(legend_labels{1},',');
legend_labels = legend_labels(2:end);

% Create a bar graph of the precipitation data with legend
bar(ylevel)
legend(legend_labels, 'FontSize', 14)

% Add labels for the axes and title
xticks(1:12);
xlabel('Month','FontSize',18);
ylabel('Precipitation(mm)','FontSize',18);
title('Monthly Average Precipitation for Validation Period','FontSize',22);

% Increase font size of xtick and ytick
set(gca, 'FontSize', 16)
