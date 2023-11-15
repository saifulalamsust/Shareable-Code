% Define start and end dates
start_date = '01-Jan-1981';
end_date = '31-Dec-2015';

% Convert start and end dates to serial date format
start_serial = datenum(start_date);
end_serial = datenum(end_date);

% Create date vector from start to end date
date_vector = start_serial:end_serial;

% Convert date vector to date strings in format yyyy-mm-dd
date_strings = datestr(date_vector, 'yyyy-mm-dd');

% Split date strings into year, month, and day
year = str2num(date_strings(:,1:4));
month = str2num(date_strings(:,6:7));
day = str2num(date_strings(:,9:10));

% Combine year, month, and day vectors into table
date_table = table(year, month, day);

% Define filename and folder path for Excel file
filename = 'date_table_2015-2100.xlsx';
folder_path = 'C:\Users\saifu\Desktop\Analysis\SDSM\Sylhet\Calibration';

% Write table to Excel file in specified folder
full_path = fullfile(folder_path, filename);
writetable(date_table, full_path);
