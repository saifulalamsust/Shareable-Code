function [monthly_corr, factor, freq_zero_month] = fn_nbc_FJ(monthly_mean, monthly_uncorr,mean_obs_m, sd_obs_m, std_obs_m,ACF_obs_m, mean_obs_a, std_obs_a, ACF_obs_a)

% NBC code to correct GCM data
% run the function 'get_obs_parameters' to obtain inputs to this function.
% monthly_mean = the current (20th century) climate data for any GCM.
% monthly_uncorr = current/future climate data for any GCM that we want to
% correct biases

%%  

if isnan(monthly_mean(1))  % Ignore ocean cells
        
        factor = NaN(length(monthly_uncorr), 1);freq_zero_month = NaN(length(monthly_uncorr), 1);
        
        monthly_corr = NaN(length(monthly_uncorr), 1);

else
        
         x = monthly_mean;
         y_mean = mean_obs_m;
         y_sd = sd_obs_m;
         y_std = std_obs_m;
         y_rho_obs = ACF_obs_m;
         y_z_mean = mean_obs_a;
         y_z_sd = std_obs_a;
         y_z_rho_obs = ACF_obs_a;
         
%==========================================================================

% Correction at monthly scale

%==========================================================================
        
% Obtain mean and standard deviation of GCMs at monthly scale for current climate
     
for mm = 1 : 12
    
      stMonth_model = mm; endMonth_model = ((length(monthly_mean)/12) - 1)*12 + mm;
      monthID_model = stMonth_model : 12 : endMonth_model;
      mean_model_m(mm) = mean(monthly_mean(monthID_model));
      sd_model_m(mm) = std(monthly_mean(monthID_model));
            
end 
     
% Obtain lag - one ACF of GCMs at monthly scale for current climate
     
  for mm = 1 : 12
    
    stMonth_model = mm; endMonth_model = ((length(monthly_mean)/12) - 1)*12 + mm;
    monthID_model = stMonth_model : 12 : endMonth_model;
    
        if mm == 1 
            ind.mm = monthID_model(2:length(monthID_model)); 
        else
            ind.mm = monthID_model; 
        end
        
        ind.mm1 = ind.mm - 1;
        [R] = corrcoef(monthly_mean(ind.mm), monthly_mean(ind.mm1));ACF_model_m(mm)=R(2);
    
  end      
     
         x_mean = mean_model_m;
         x_sd = sd_model_m;
         x_rho_model = ACF_model_m;     
     
% Find residual for current or future climate data that we want to correct biases 
     
for mm = 1 : 12
     
      stMonth_model = mm; endMonth_model = ((length(monthly_uncorr)/12) - 1)*12 + mm;
      
      monthID_model = stMonth_model : 12 : endMonth_model;
         
      std_model_m(monthID_model) = (monthly_uncorr(monthID_model) - mean_model_m (mm)) / sd_model_m(mm);
           
end 
       x_std = std_model_m;     
     
     
% Remove lag - one AC for data we want to correct biases 
   
for i = 2 : length (monthly_uncorr)
         
         p1 = repmat(1:12, 1, 200);p=p1(i);      % 200 is just to repeat the indices many times 
         x_std_uncor(i) = (x_std(i) - (x_rho_model(p) * x_std(i-1)))/sqrt(1 - x_rho_model(p)^2);
         
end 
            
       
% Apply lag-one autocorrelation from observation to the data we want to
% correct biases
     
     x_std_cor = x_std_uncor;
     
for i = 2 : length(monthly_uncorr)
         
         p1 = repmat(1:12, 1, 200);p=p1(i);    % 200 is just repeat the indices many times 
         x_std_cor(i) = y_rho_obs(p) * x_std_cor(i-1) + sqrt(1 - y_rho_obs(p)^2)* x_std_uncor(i);
         
end        
       

% Rescale data to observation mean and standard deviation

     x_std_cor = x_std;
     
for  i = 1 : length(x_std_cor)
         
        p1 = repmat(1:12, 1, 200);p=p1(i);    % 200 is just repeat the indices many times 

        x_std_cor(i) = x_std_cor(i) * y_sd(p) + y_mean(p);
        
end 
     
        x_std_cor(x_std_cor<0) = 0;         % remove values less than zero
    
        freq_zero_month = sum(x_std_cor<0); % frequency of less than zero for a grid cell
        
 
%==========================================================================        
        
% Correction at annual scale

%==========================================================================        
        
% Aggregate to annual data 

% 
% for y = 1 : length(x_std_cor)/12
%            
%         mspan = (y - 1) * 12 + 1 : (y - 1) * 12 + 12;
%            
%         x_z(y) = sum(x_std_cor(mspan));
%            
% end 
%         
% % Mean and standard deviation of annual data 
%     
%         x_z_mean = mean(x_z);
%          
%         x_z_sd = std(x_z);
%         
%         x_z_std = (x_z - x_z_mean)/x_z_sd;
%         
%         [ACF] = autocorr(x_z, 1); x_z_rho_model = ACF(2);
% 
% 
% % Remove lag one ACF
%    
% x_z_std_uncor = x_z_std;
%      
% for i = 2 : length (x_z_std)
%          
%        x_z_std_uncor(i) = (x_z_std(i) - x_z_rho_model * x_z_std(i-1))/sqrt(1 - x_z_rho_model^2);
%          
% end 
% 
% % Apply lag-one ACF from observation 
%     
%      x_z_std_cor = x_z_std_uncor;
%      
% for i = 2 : length (x_z_std)
%          
%       x_z_std_cor(i) = y_z_rho_obs * x_z_std_cor(i-1) + sqrt(1 - y_z_rho_obs ^2)* x_z_std_uncor(i);
%          
% end 
%      
% % Rescale to observation mean and standard deviation
%    
% for  i = 1 : length(x_z_std_cor)
%          
%         x_z_std_cor(i) = x_z_std_cor(i) * y_z_sd + y_z_mean;
%         
% end 

%==========================================================================        
        
% Correct biases

%========================================================================== 

% % Create constants through a tolerance function 
%            
%      tol = 0.1;
%      
% % monthly constant 
%      
%      month_const = x_std_cor./monthly_uncorr(:)';
%      
%      month_const(isnan(month_const)) = 0;     % if dividing by zero, take as zero
% 
%      month_const_0 = month_const;             % month_const without forcing to zero
%      
%      month_const(monthly_uncorr<tol) = 0;     % if monthly_uncorr is small, take as zero
%      
% % yearly constant 
%      
%      year_const = x_z_std_cor./x_z;
%      
%      year_const(x_z_std_cor<tol) = 0;     % check whether we have to use x_z or x_z_std_cor ? Fiona code uses x_z_std_cor.
%      
%      year_const(isnan(year_const)) = 0;
%       
%      year_const(year_const < 0) = 0;
% 
%      year_const_rep = repmat(year_const, 1, 12);
%      
%      temp = year_const_rep;
%      
% for i = 1 : 12
%          
%      sti = i; endi = ((length(year_const_rep)/12) - 1)*12 + i;
% 
%      mspan = sti : 12 : endi;
%      
%      temp(mspan) = year_const;
%      
% end 
%          
%      year_const_rep = temp;
%          
%      factor = NaN(length(x_std_cor),1);
%      
%      factor_0 = NaN(length(x_std_cor),1);
%      
% for i = 1 : length(x_std_cor)
%          
%       ratio = month_const(i) * year_const_rep(i);
%       
%       ratio(ratio < 0.1) = 0.1; % do not allow ratio to be excessively high
%       
%       ratio(ratio > 10) = 10; % do not allow ratio to be excessively high
%       
% 
%       ratio_0 = month_const_0(i) * year_const_rep(i);
%       
%       ratio_0(ratio_0 < 0.1) = 0.1; % do not allow ratio to be excessively high
%       
%       ratio_0(ratio_0 > 10) = 10; % do not allow ratio to be excessively high
%       
%       factor (i) = ratio;
%       
%       factor_0 (i) = ratio_0;
%          
% end 
%           
%      monthly_corr = factor .* monthly_uncorr(:);
      
%      monthly_corr_0 = factor_0 .* monthly_uncorr(:);
%      
%      monthly_corr = monthly_corr;
%      
%      monthly_corr_0 = monthly_corr_0;
%      
%      monthly_corr = monthly_corr * mean(monthly_corr_0)/mean(monthly_corr); % rescale the overall mean to after forcing to zero to be equal to be before forcing to zero
     
     monthly_corr = x_std_cor;

     monthly_corr(monthly_corr<0) = 0; % force negative values if there is any negative left over.
              
end 

