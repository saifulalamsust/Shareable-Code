% Set the directory where the .out files are located
directory = 'F:\Research\Drought Thesis\Analysis\SDSM\Temperature Processed data\ERA5 Downscaled\Tmin\';

% Get a list of all .out files in the directory
file_list = dir(fullfile(directory, '*.out'));

% Loop over all .out files in the directory
for i = 1:length(file_list)
    
    % Get the filename of the current file
    filename = fullfile(directory, file_list(i).name);
    
    % Open the current .out file for reading
    fid = fopen(filename, 'r');
    
    % Read the data into a matrix
    data = fscanf(fid, '%f', [20, Inf]);
    data = data';
    
    % Calculate the row-wise mean
    mean_data = mean(data, 2);
    
    % Create a date range from 01012015 to 31122099
    start_date = datetime('01011981','InputFormat','ddMMyyyy');
    end_date = datetime('31122010','InputFormat','ddMMyyyy');
    num_dates = size(data, 1);
    dates = linspace(start_date, end_date, num_dates)';
    
    % Convert the dates to strings with the desired format
    date_strings = datestr(dates, 'dd-mm-yyyy');
    
    % Combine the dates and mean data into a table
    table_data = table(date_strings, mean_data, 'VariableNames', {'Date', 'Tmin_His'});
    
    % Get the original filename without the extension
    [~, name, ~] = fileparts(filename);
    
    % Save the table as an Excel file with the same name in the same folder
    writetable(table_data, fullfile(directory, [name '.xlsx']), 'Sheet', 1, 'Range', 'A1');
    
    % Close the current .out file
    fclose(fid);
    
end

