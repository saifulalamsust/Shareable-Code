% Define the start and end years
start_year = 2015;
end_year = 2100;

% Create an array of all the years in the range
years = start_year:end_year;

% Create an empty matrix to hold the year-month pairs
year_month_pairs = [];

% Loop over each year in the range
for i = 1:length(years)
    % For each year, create an array of month numbers from 1 to 12
    months = ones(12,1) .* (1:12)';
    
    % Create an array of the corresponding year numbers
    year_nums = ones(12,1) .* years(i);
    
    % Concatenate the year and month arrays vertically to form a matrix
    year_month_matrix = [year_nums, months];
    
    % Append the year-month matrix to the overall year-month pairs matrix
    year_month_pairs = [year_month_pairs; year_month_matrix];
end

% Display the resulting matrix
disp(year_month_pairs);