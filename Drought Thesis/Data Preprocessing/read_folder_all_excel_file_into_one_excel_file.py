import pandas as pd
import os

path = r'F:\Research\Drought Thesis\Analysis\SDSM\Temperature Processed data\SSP245 Downscaled\Tmax'
all_files = os.listdir(path)

df = pd.DataFrame()

for file in all_files:
    if file.endswith('.xlsx'):
        file_path = os.path.join(path, file)
        temp_df = pd.read_excel(file_path)
        station_name = file.split('.')[0]
        df[station_name] = temp_df['Tmax_SSP245']

df.index = temp_df['Date']
print(df)


output_folder = r'F:\Research\Drought Thesis\Analysis\SDSM\Temperature Processed data\ERA5 Downscaled'
#file_name = 'Tmax_SSP245 Downscaled.csv'

#df.to_csv(os.path.join(output_folder, file_name))