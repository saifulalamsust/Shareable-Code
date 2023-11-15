% Set directory containing .txt files
dir_path = 'C:\Users\saifu\Desktop\Analysis\SPI\SPI3';

% Get list of all .txt files in directory
txt_files = dir(fullfile(dir_path, '*.txt'));

% Initialize empty matrix to store precipitation data
data = [];

% Loop through each .txt file
for i=1:length(txt_files)
    % Read .txt file
    file_path = fullfile(dir_path, txt_files(i).name);
    file_data = dlmread(file_path);

    % Add column of precipitation data to data matrix
    data(:,i) = file_data;

    % Extract name of .txt file and use as column label in Excel file
    [~,file_name,~] = fileparts(file_path);
    col_labels{i} = file_name;
end

% Write data matrix to Excel file
output_file = 'precipitation_data.xlsx';
xlswrite(output_file, [col_labels; num2cell(data)]);
