% Set the path to the folder containing the .txt files
folder_path = 'C:\Users\saifu\Desktop\Analysis\SPI\1981-2021';

% Set the path to the output folder for the new .txt files
output_folder_path = 'C:\Users\saifu\Desktop\Analysis\SPI\Prepared for SDAT\Observed';

% Get a list of all .txt files in the folder
files = dir(fullfile(folder_path, '*.txt'));

% Loop through each file and extract the first 360 values
for i = 1:length(files)
    % Get the filename and full path for the current file
    file_name = files(i).name;
    file_path = fullfile(folder_path, file_name);
    
    % Load the data from the file
    data = load(file_path);
    
    % Extract the first 360 values
    first_360 = data(1:360);
    
    % Create the output file name and path
    output_file_name = file_name;
    output_file_path = fullfile(output_folder_path, output_file_name);
    
    % Write the first 360 values to the output file
    fid = fopen(output_file_path, 'w');
    fprintf(fid, '%f\n', first_360);
    fclose(fid);
end
