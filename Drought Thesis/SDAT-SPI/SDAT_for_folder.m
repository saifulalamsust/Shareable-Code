% set path to the data folder
dataFolder = 'F:\Research\Drought Thesis\NBC\Raw\Tutorial\1981-2021';

plotFolder = 'F:\Research\Drought Thesis\NBC\Raw\Tutorial\1981-2021\Plot\SPI6';

% get all .txt files in the folder
fileList = dir(fullfile(dataFolder, '*.txt'));

% Choose line style for black and white
lineStyle = '-';

for i=1:length(fileList)
% load data from the current file
filename = fullfile(dataFolder, fileList(i).name);
td = load(filename);

% use the file name as plot title
[~, titleStr, ~] = fileparts(filename);
plotTitle = [titleStr ' (Historical)'];

% sc: scale of the index (>1, e.g., 3-month SPI or SSI)
sc=6;

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
plot(SI, lineStyle, 'linewidth',0.7, 'Color', [0 0 0]);
xlabel('Year')
grid on
xticks(7:24:493)
xticklabels({'1981', '1983', '1985', '1987', '1989', '1991', '1993', '1995', '1997', '1999', '2001', '2003', '2005', '2007', '2009', '2011', '2013', '2015', '2017', '2019', '2021'})
title(plotTitle,'FontSize', 16) % use file name as plot title
ylabel('SDAT-SPI 6','FontSize', 16)
% Modify XXXX as fit (e.g., Precipitation for SPI)

% save the figure in a separate folder with JPEG format and the same file name as the input text file
saveas(fig, fullfile(plotFolder, [titleStr '.jpeg']));
end
