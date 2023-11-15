% set path to the data folder
dataFolder = 'C:\Users\saifu\Desktop\Analysis\SPI\NBC Downscaled Data\SSP585_NBC\NF_NBC';

% create a new folder called "Plots" to save the plots
plotFolder = 'C:\Users\saifu\Desktop\Analysis\SPI\NBC Downscaled Data\SSP585_NBC\NF_NBC\SPI_12_NF_SSP585';

% get all .txt files in the folder
fileList = dir(fullfile(dataFolder, '*.txt'));

% create a cell array to store SI values and file names
SI_table = cell(length(fileList)+1, 361);

for i=1:length(fileList)
% load data from the current file
filename = fullfile(dataFolder, fileList(i).name);
td = load(filename);

% use the file name as plot title
[~, titleStr, ~] = fileparts(filename);
plotTitle = [titleStr ' (SSP 585-Near Future)'];

% sc: scale of the index (>1, e.g., 3-month SPI or SSI)
sc=12;

n=length(td);

SI=zeros(n,1);

% Compute the SPI for each grid from the prcp or smc data

% For some grid, no observation exist.
if length(td(td>=0))/length(td)~=1
    SI(n,1)=nan;
else
    % Obtain the prcp and smc for the specified time scale and
    % compute the standarized drought index (for SPI and SSI)
    SI(1:sc-1,1)=nan;

    A1=[];
    for j=1:sc,
        A1=[A1,td(j:length(td)-sc+j)];
    end
    Y=sum(A1,2);

    % Compute the SPI or SSI

    nn=length(Y);
    SI1=zeros(nn,1);

    for k=1:12
        d=Y(k:12:nn);
        % compute the empirical probability
        nnn=length(d);
        bp=zeros(nnn,1);

        for l=1:nnn
            bp(l,1)=sum(d(:,1)<=d(l,1));
        end

        y=(bp-0.44)./(nnn+0.12);

        SI1(k:12:nn,1)=y;
    end

    SI1(:,1)=norminv(SI1(:,1));
    % output
    SI(sc:end,1)=SI1;
end

% plot vector
fig = figure('visible', 'off');
plot(SI, 'linewidth',1.5);
xlabel('Year')
grid on
xticks(7:12:365)
xticklabels({'2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030', '2031', '2032', '2033','2034', '2035', '2036', '2037', '2038', '2039', '2040', '2041', '2042', '2043', '2044','2045', '2046', '2047', '2048', '2049', '2050', '2051', '2052'})
title(plotTitle,'FontSize', 16) % use file name as plot title
ylabel('Standardized Precipitation Index (SPI-12)','FontSize', 15)
% Modify XXXX as fit (e.g., Precipitation for SPI)

% save the figure in a separate folder with JPEG format and the same file name as the input text file
saveas(fig, fullfile(plotFolder, [titleStr '.jpeg']));

% add SI values to the table
SI_table{i+1,1} = titleStr;
SI_table(i+1,2:end) = num2cell(SI');
end

% Create transpose of SI_table
SI_table1 = SI_table';

% Save SI_table1 in plotFolder with filename based on plotFolder name
[~, foldername] = fileparts(plotFolder);
filename = fullfile(plotFolder, [foldername, '_SI_table1.xlsx']);
writetable(array2table(SI_table1), filename);
