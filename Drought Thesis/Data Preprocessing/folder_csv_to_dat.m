% Set the folder containing the CSV files
folder_path = 'F:\Research\Drought Thesis\Analysis\SDSM\Processed Data\34x41 processed dat\NCEP';

% Get a list of all CSV files in the folder
file_list = dir(fullfile(folder_path, '*.csv'));

% Loop through each file in the list
for i=1:length(file_list)
    % Load the CSV file
    file_path = fullfile(file_list(i).folder, file_list(i).name);
    data = readtable(file_path);

    % Write the new data to a DAT file with the same name
    [~, file_name] = fileparts(file_path);
    output_path = fullfile(file_list(i).folder, [file_name '.dat']);
    writetable(data, output_path, 'Delimiter', ' ', 'WriteRowNames', false, 'WriteVariableNames', false);
    
%     % Delete the original CSV file
%     delete(file_path);
end