% Define the input and output folder paths
inputFolder = 'C:\Users\saifu\Desktop\Analysis\SDSM\Downscaled Data\Monthly\Prepared for SDAT\Historical';
outputFolder = 'C:\Users\saifu\Desktop\Analysis\SPI\Prepared for SDAT\Historical';

% Get a list of all .txt files in the input folder
fileList = dir(fullfile(inputFolder, '*.txt'));

% Loop through each file in the input folder
for ii = 1:length(fileList)
    % Get the current file name and full file path
    fileName = fileList(ii).name;
    filePath = fullfile(inputFolder, fileName);
    
    % Extract the new file name by removing the underscore and everything after it
    newName = fileName(1:strfind(fileName, '_')-1);
    
    % Construct the full file path for the new file in the output folder
    newFilePath = fullfile(outputFolder, [newName '.txt']);
    
    % Copy the file to the output folder with the new name
    copyfile(filePath, newFilePath);
end
