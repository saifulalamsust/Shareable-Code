% Get a list of all the .csv files in the folder
folder = 'C:\Users\saifu\Desktop\Analysis\SDSM\Sylhet\Raw File\MPI & NorESM2\MPI-ESM1-2-HR_historical_BOX_034X_41Y\Original';

% Get a list of .csv files in the folder
csv_files = dir(fullfile(folder, '*.csv'));

% Iterate through the list of .csv files
for k = 1:length(csv_files)

    % Open the .csv file in read mode
    csv_file = csv_files(k).name;
    input_file = fopen(fullfile(folder, csv_file), 'r');

    % Create the .csv file in write mode
    csv_file = strrep(csv_file, '.csv', '.csv');
    csv_file = ['mpi5', csv_file(1:4), 'gl.csv'];
    output_path = 'C:\Users\saifu\Desktop\Analysis\SDSM\Sylhet\Calibration\MPI_H_original';
    output_file = fopen(fullfile(output_path, csv_file), 'w');

    % Iterate through the lines of the .csv file
    lines = textscan(input_file, '%s', 'delimiter', '\n');
    for i = 1:length(lines{1})
        % Write the line to the .csv file
        if i >= 732 && i <= 9862
            if i < 9862
                fprintf(output_file, '%s,\n', char(lines{1}(i)));
            else
                fprintf(output_file, '%s', char(strtrim(lines{1}(i))));
            end
        end
    end

    % Close the .csv file and the input file
    fclose(input_file);
    fclose(output_file);

end
