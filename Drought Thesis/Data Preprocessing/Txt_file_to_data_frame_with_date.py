import pandas as pd
import os

path = r'F:/Research/Drought Thesis/Analysis/SDSM/Calibration And Validation MPI/Rainfall/Row'
all_files = os.listdir(path)

df = pd.DataFrame()

for file in all_files:
    station_name = file.split('.')[0]
    file_path = os.path.join(path, file)
    temp_df = pd.read_csv(file_path, header=None)
    temp_df.columns = [station_name]
    if 'Date' not in df.columns:
        df['Date'] = pd.date_range(start='1981-01-01', end='2021-12-01', freq='MS').strftime('%m-%Y')
    df[station_name] = temp_df[station_name]

print(df)


output_folder = r'F:\Research\Drought Thesis\Analysis\SDSM\Calibration And Validation MPI\Rainfall'
file_name = 'Observed_monthly_rainfall_1981-2021.csv'

df.to_csv(os.path.join(output_folder, file_name), index=False)