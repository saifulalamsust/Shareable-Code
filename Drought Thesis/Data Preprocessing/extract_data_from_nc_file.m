% Define the filename of your netCDF file
input_foldername = 'C:\Users\S_PC\Desktop\Temporary';
input_filename = fullfile(input_foldername, 'adaptor.mars.internal-1686928074.02137-12306-6-89d77ef8-9164-45b6-bddc-4fbc5963652f.nc');

% Define the desired latitude and longitude
lat_desired = 23.79;
lon_desired = 90.42;

% Read in the latitude, longitude, and variable data from the netCDF file
ncid = netcdf.open(input_filename,'NC_NOWRITE');
latid = netcdf.inqVarID(ncid, 'latitude');
lonid = netcdf.inqVarID(ncid, 'longitude');
d2mid = netcdf.inqVarID(ncid, 'd2m');
mslid = netcdf.inqVarID(ncid, 'msl');
t2mid = netcdf.inqVarID(ncid, 't2m');
tpid = netcdf.inqVarID(ncid, 'tp');
v10id = netcdf.inqVarID(ncid, 'v10');
u10id = netcdf.inqVarID(ncid, 'u10');
timeid = netcdf.inqVarID(ncid, 'time');

lat = netcdf.getVar(ncid,latid);
lon = netcdf.getVar(ncid,lonid);
data_d2m = netcdf.getVar(ncid,d2mid);
data_msl = netcdf.getVar(ncid,mslid);
data_t2m = netcdf.getVar(ncid,t2mid);
data_tp = netcdf.getVar(ncid,tpid);
data_v10 = netcdf.getVar(ncid,v10id);
data_u10 = netcdf.getVar(ncid,u10id);
time = netcdf.getVar(ncid,timeid);

netcdf.close(ncid);

% Find the indices of the nearest latitude and longitude grid points
[~, lat_index] = min(abs(lat - lat_desired));
[~, lon_index] = min(abs(lon - lon_desired));

% Extract the data at the desired latitude and longitude point and time
data_d2m_point = squeeze(data_d2m(lon_index, lat_index, :));
data_msl_point = squeeze(data_msl(lon_index, lat_index, :));
data_t2m_point = squeeze(data_t2m(lon_index, lat_index, :));
data_tp_point = squeeze(data_tp(lon_index, lat_index, :));
data_v10_point = squeeze(data_v10(lon_index, lat_index, :));
data_u10_point = squeeze(data_u10(lon_index, lat_index, :));

% Save the extracted data to an Excel file with time as the first column
output_filename = fullfile(input_foldername, 'output.xlsx');
table_data = table(data_d2m_point, data_msl_point, data_t2m_point, data_tp_point, data_v10_point, data_u10_point);
writetable(table_data, output_filename, 'Sheet', 'Data', 'WriteVariableNames', true);
