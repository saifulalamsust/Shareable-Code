% Load data from excel file
data = readtable('Data sheet.xlsx');

% Extract time and station data
time = datenum(data{:,1});
stations = data(:,2:end);

% Plot each station as a separate line
figure;
hold on;
for i = 1:size(stations,2)
    plot(time, stations{:,i})
end

% Format the plot
title('Time series data for multiple stations');
xlabel('Time');
ylabel('Station Data');
datetick('x');
legend(data.Properties.VariableNames(2:end));
