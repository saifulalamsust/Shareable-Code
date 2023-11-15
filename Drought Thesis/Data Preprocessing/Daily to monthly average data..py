import pandas as pd
import os


file_path = r'F:\Research\Drought Thesis\Analysis\SDSM\Temperature Processed data\Tmin_SSP245 Downscaled.csv'

df = pd.read_csv(file_path)


df['Date'] = pd.to_datetime(df['Date'], format='%m/%d/%Y', errors='coerce')
df['Date'] = pd.to_datetime(df['Date'], format='%d-%m-%Y', errors='coerce')
df.set_index('Date', inplace=True)

##Each Month Average Defining
#monthly_avg = df.groupby(df.index.month).mean()
#monthly_avg.index = monthly_avg.index.map(lambda x: pd.to_datetime(x, format='%m').strftime('%B'))


#Monthly Average Data Calculation
monthly_avg = df.groupby(pd.Grouper(freq='M')).mean()

output_folder = r'F:\Research\Drought Thesis\Analysis\SDSM\Temperature Processed data\Monthly Converted'
file_name = 'Tmin_SSP245.csv'

monthly_avg.to_csv(os.path.join(output_folder, file_name))


print(monthly_avg)