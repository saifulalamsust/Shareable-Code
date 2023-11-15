
function [mean_obs_m, sd_obs_m, std_obs_m,ACF_obs_m, mean_obs_a, sd_obs_a, ACF_obs_a] = get_obs_parametres(UDELdata)

% Skip if the grid is a water cell

    if isnan(UDELdata(1))
        
        mean_obs_m = [];sd_obs_m = [];std_obs_m = [];
        ACF_obs_m = [];mean_obs_a = [];sd_obs_a = [];ACF_obs_a=[];
        
    else 
        

% Determine mean, standard deviation and residue of observations

for m = 1 : 12
    
      stMonth = m; endMonth = ((length(UDELdata)/12) - 1)*12 + m;
      
      monthID = stMonth : 12 : endMonth;
    
      mean_obs_m(m) = mean(UDELdata(monthID));
      
      sd_obs_m(m) = std(UDELdata(monthID));
      
      std_obs_m(monthID) = (UDELdata(monthID) - mean_obs_m (m)) / sd_obs_m(m);
      
end 

% Lag one autocorrelation of monthly models 

for m = 1 : 12
    
    stMonth = m; endMonth = ((length(UDELdata)/12) - 1)*12 + m;
      
    monthID = stMonth : 12 : endMonth;
    
        if m == 1 
            ind.m = monthID(2:length(monthID)); 
        else
            ind.m = monthID; 
        end
        
        ind.m1 = ind.m - 1;
    
        [R] = corrcoef(UDELdata(ind.m), UDELdata(ind.m1));ACF_obs_m(m)=R(2);
    
end 

% Re-do with yearly data

% Aggregate to annual data 

   for y = 1 : length(UDELdata)/12
           
        mspan = (y - 1) * 12 + 1 : (y - 1) * 12 + 12;
           
        UDELdata_a(y) = sum(UDELdata(mspan));
           
   end 

% Calculate mean, standard deviation and lag-one autocorrelation

        mean_obs_a = mean(UDELdata_a);
        
        sd_obs_a = std(UDELdata_a);
        
        [ACF] = autocorr(UDELdata_a, 1); ACF_obs_a = ACF(2);
        
   
    end 

end 

