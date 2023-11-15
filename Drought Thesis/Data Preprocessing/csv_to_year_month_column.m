% Load the Excel file
filename = 'Sylhet_CE_SSP245_2015-2100.xlsx';
[~, ~, data] = xlsread(filename);

% Extract the date range from 01-Jan-2015 to 31-Dec-2100 (365-day calendar)
start_date = datetime(2015, 1, 1);
end_date = datetime(2100, 12, 31);
num_years = end_date.Year - start_date.Year + 1;
date_range = NaT(num_years*365,1,'TimeZone','local');
precip_data = NaN(num_years*365,1);
n=1;
for y=start_date.Year:end_date.Year
    for m=1:12
        if m==2 % February has 28 days in non-leap years
            num_days = 28;
        elseif any(m==[4 6 9 11]) % April, June, September, November have 30 days
            num_days = 30;
        else % All other months have 31 days
            num_days = 31;
        end
        for d=1:num_days
            date_range(n) = datetime(y,m,d,'TimeZone','local');
            precip_data(n) = data{n};
            n=n+1;
        end
    end
end

% Create a CSV file with year, month, day, and precipitation data
[filepath, base_filename, extension] = fileparts(filename);
csv_filename = fullfile(filepath, [base_filename, '_output.csv']);
if exist(csv_filename,'file')
    fid = fopen(csv_filename, 'a'); % Append to existing file
else
    fid = fopen(csv_filename, 'w'); % Create new file
    fprintf(fid, 'Year,Month,Day,Precipitation\n');
end
for i = 1:numel(date_range)
    if exist('fid','var')
        fprintf(fid, '%d,%d,%d,%f\n', year(date_range(i)), month(date_range(i)), day(date_range(i)), precip_data(i));
    else
        error('File identifier is missing. Check that the file exists and has been opened correctly.')
    end
end
fclose(fid);