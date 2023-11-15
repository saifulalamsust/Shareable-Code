% Get a list of all the .csv files in the folder
folder = 'C:\Users\saifu\Desktop\Analysis\SDSM\Raw Data\ECMWF_ERA5_BOX_034X_41Y\Standardized';
csv_files = dir(fullfile(folder, '*.csv'));

% Iterate through the list of .csv files
for k = 1:length(csv_files)

    % Open the .csv file in read mode
    csv_file = csv_files(k).name;
    input_file = fopen(fullfile(folder, csv_file), 'r');

    % Create the .csv file in write mode
    csv_file = strrep(csv_file, '.csv', '.csv');
    csv_file = ['era5', csv_file(1:4), 'gl.csv'];
    output_path = 'C:\Users\saifu\Desktop\Analysis\SDSM\Raw Data\ECMWF_ERA5_BOX_034X_41Y\ECMWF_ERA5_BOX_034X_41Y';
    output_file = fopen(fullfile(output_path, csv_file), 'w');

    % Iterate through the lines of the .csv file
    lines = textscan(input_file, '%s', 'delimiter', '\n');
    for i = 1:length(lines{1})
        % Skip the first 731 lines
        if i <= 731
            continue
        end
        
        % Stop writing lines after the 11688th line
        if i > 11688
            break
        end
        
        % Write the line to the .csv file
        if i < length(lines{1})
            fprintf(output_file, '%s,\n', char(lines{1}(i)));
        else
            fprintf(output_file, '%s', char(strtrim(lines{1}(i))));
        end
    end

    % Close the .csv file and the input file
    fclose(input_file);
    fclose(output_file);

end