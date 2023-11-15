% input file path
input_folder_path = 'C:\Users\saifu\Desktop\Analysis\SDSM\Sylhet\Calibration\NBC';
% output folder path
output_folder_path = 'C:\Users\saifu\Desktop\Analysis\SDSM\Sylhet\Calibration\NBC';

% load observed data
observed_data = load('obs_sylhet_val.txt');
% load historical GCM data
monthly_uncorr = load('downscaled_mpi_sylhet_val.txt');
% load Near Future GCM data
monthly_uncorr1 = load('MPI_ssp245.txt');
% load Far Future GCM data
monthly_uncorr2 = load('2025_29_sylhet.txt');
% N B: All data set should be in same length

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



% extract the input folder name
[~, folder_name, ~] = fileparts(input_folder_path);

% save monthly_corr to text file
output_file_name = sprintf('%s_monthly_corr_with_raw.txt', folder_name);
output_file_path = fullfile(output_folder_path, output_file_name);
dlmwrite(output_file_path, monthly_corr, 'delimiter', '\t');

% save monthly_corr1 to text file
output_file_name = sprintf('%s_monthly_corr1.txt', folder_name);
output_file_path = fullfile(output_folder_path, output_file_name);
dlmwrite(output_file_path, monthly_corr1, 'delimiter', '\t');

% save monthly_corr2 to text file
output_file_name = sprintf('%s_monthly_corr2.txt', folder_name);
output_file_path = fullfile(output_folder_path, output_file_name);
dlmwrite(output_file_path, monthly_corr2, 'delimiter', '\t');