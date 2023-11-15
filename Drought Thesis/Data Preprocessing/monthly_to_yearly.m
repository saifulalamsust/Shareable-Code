% Specify input and output folders
input_folder = 'C:\Users\saifu\Desktop\Analysis\SPI\1981-2021';
output_folder = 'F:\Research\Drought Thesis\seqMK\Observed 1981-2021';

% Get list of all files in input folder
file_list = dir(fullfile(input_folder, '*.txt'));

% Loop over each file in the list
for i = 1:numel(file_list)
    
    % Load precipitation data from text file
    file_name = file_list(i).name;
    data = load(fullfile(input_folder, file_name));
    
    % Calculate number of years in the data
    num_years = floor(length(data) / 12);
    
    % Initialize array to store yearly sums
    yearly_sums = zeros(num_years, 1);
    
    % Loop over years and sum precipitation values
    for j = 1:num_years
        start_idx = (j-1)*12 + 1;
        end_idx = j*12;
        yearly_sums(j) = sum(data(start_idx:end_idx));
    end
    
    % Create array of consecutive years starting from 1981
    years = (1981 : 1981+num_years-1)';
    
    % Concatenate years and yearly sums into matrix
    output_matrix = [years, yearly_sums];
    
    % Construct output file path and name
    [~, file_base, ~] = fileparts(file_name);
    output_file = fullfile(output_folder, [file_base '.xlsx']);
    
    % Write matrix to Excel file
    writematrix(output_matrix, output_file);
end
