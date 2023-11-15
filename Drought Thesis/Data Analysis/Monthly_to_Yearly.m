% Specify input folder and output folder
input_folder = 'F:\Research\Drought Project\Report\Report 1\Data\GCM Daily\Temp\';
output_folder = 'F:\Research\Drought Project\Report\Report 1\Data\GCM Daily\Temp\Anually\';

% Get a list of all txt files in the input folder
file_list = dir(fullfile(input_folder, '*.txt'));

% Loop through each file in the list
for i = 1:length(file_list)
    % Get the input filename and path
    input_filename = file_list(i).name;
    input_path = fullfile(input_folder, input_filename);
    
    % Read monthly precipitation data from input file
    data = dlmread(input_path);

    % Reshape the data into annual intervals by average every 365 consecutive rows of data
    annual_data = mean(reshape(data, 365, []), 1);

    % Generate the output filename and path
    [~, name, ~] = fileparts(input_filename);
    output_filename = fullfile(output_folder, [name '.txt']);
    
    % Write annual rainfall data to output file
    dlmwrite(output_filename, annual_data');
end
