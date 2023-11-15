% input file path1
input_folder_path1 = 'C:\Users\saifu\Desktop\Analysis\SPI\Prepared for SDAT\Observed';
% input file path2
input_folder_path2 = 'C:\Users\saifu\Desktop\Analysis\SPI\Prepared for SDAT\Historical';
% input file path3
input_folder_path3 = 'C:\Users\saifu\Desktop\Analysis\SPI\Prepared for SDAT\SSP585\NF';
% input file path4
input_folder_path4 = 'C:\Users\saifu\Desktop\Analysis\SPI\Prepared for SDAT\SSP585\FF';

% output folder paths
output_folder_path2 = 'C:\Users\saifu\Desktop\Analysis\NBC Downscaled Data\Historical_NBC';
output_folder_path3 = 'C:\Users\saifu\Desktop\Analysis\NBC Downscaled Data\SSP585_NBC\NF_NBC';
output_folder_path4 = 'C:\Users\saifu\Desktop\Analysis\NBC Downscaled Data\SSP585_NBC\FF_NBC';

% create output folders if they don't exist already
if ~exist(output_folder_path2, 'dir')
    mkdir(output_folder_path2);
end
if ~exist(output_folder_path3, 'dir')
    mkdir(output_folder_path3);
end
if ~exist(output_folder_path4, 'dir')
    mkdir(output_folder_path4);
end

% load observed data
observed_data = load(fullfile(input_folder_path1, 'Chittagong.txt'));

% load historical GCM data
monthly_uncorr = load(fullfile(input_folder_path2, 'Chittagong.txt'));

% load Near Future GCM data
monthly_uncorr1 = load(fullfile(input_folder_path3, 'Chittagong.txt'));

% load Far Future GCM data
monthly_uncorr2 = load(fullfile(input_folder_path4, 'Chittagong.txt'));

% N B: All data sets should be of the same length

UDELdata= observed_data;
[mean_obs_m, sd_obs_m, std_obs_m,ACF_obs_m, mean_obs_a, sd_obs_a, ACF_obs_a] = get_obs_parametres(UDELdata);
[monthly_corr] = fn_nbc_FJ(monthly_uncorr,monthly_uncorr,mean_obs_m, sd_obs_m, std_obs_m,ACF_obs_m, mean_obs_a, sd_obs_a, ACF_obs_a);
% RMSE = sqrt(mean((UDELdata - monthly_uncorr).^2));  % Root Mean Squared Error
% RMSE1 = sqrt(mean((UDELdata - monthly_corr).^2));  % Root Mean Squared Error
[monthly_corr1] = fn_nbc_FJ(monthly_uncorr,monthly_uncorr1,mean_obs_m, sd_obs_m, std_obs_m,ACF_obs_m, mean_obs_a, sd_obs_a, ACF_obs_a);
[monthly_corr2] = fn_nbc_FJ(monthly_uncorr,monthly_uncorr2,mean_obs_m, sd_obs_m, std_obs_m,ACF_obs_m, mean_obs_a, sd_obs_a, ACF_obs_a);

%%seasonal SWE
monthly_corr=monthly_corr';
monthly_corr1=monthly_corr1';
monthly_corr2=monthly_corr2';

m1=mean(observed_data);
m2=mean(monthly_uncorr);
m3=mean(monthly_corr);

% write output files in respective folders with input folder name as file name
output_file_name = 'Chittagong.txt';
output_file_path2 = fullfile(output_folder_path2, output_file_name);
output_file_path3 = fullfile(output_folder_path3, output_file_name);
output_file_path4 = fullfile(output_folder_path4, output_file_name);

dlmwrite(output_file_path2, monthly_corr, 'delimiter', '\t');
dlmwrite(output_file_path3, monthly_corr1, 'delimiter', '\t');
dlmwrite(output_file_path4, monthly_corr2, 'delimiter', '\t');
