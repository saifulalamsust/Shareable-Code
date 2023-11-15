%% % Nux hist
[c,~,a]=unique(can_phist(:,1:2),'rows');
can_hist_nux=[c,accumarray(a,can_phist(:,22),[],@nansum)];
[c,~,a]=unique(hd_phist(:,1:2),'rows');
hd_hist_nux=[c,accumarray(a,hd_phist(:,22),[],@nansum)];
[c,~,a]=unique(lr_phist(:,1:2),'rows');
lr_hist_nux=[c,accumarray(a,lr_phist(:,22),[],@nansum)];
[c,~,a]=unique(gfdl_phist(:,1:2),'rows');
gfdl_hist_nux=[c,accumarray(a,gfdl_phist(:,22),[],@nansum)];
[c,~,a]=unique(ec_phist(:,1:2),'rows');
rec_hist_nux=[c,accumarray(a,ec_phist(:,22),[],@nansum)];
[c,~,a]=unique(rhd_phist(:,1:2),'rows');
rhd_hist_nux=[c,accumarray(a,rhd_phist(:,22),[],@nansum)];
[c,~,a]=unique(rlr_phist(:,1:2),'rows');
rlr_hist_nux=[c,accumarray(a,rlr_phist(:,22),[],@nansum)];
% NF
[c,~,a]=unique(can_pnear_bc(:,1:2),'rows');
can_NF_nux=[c,accumarray(a,can_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(hd_pnear(:,1:2),'rows');
hd_NF_nux=[c,accumarray(a,hd_pnear(:,22),[],@nansum)];
[c,~,a]=unique(lr_pnear(:,1:2),'rows');
lr_NF_nux=[c,accumarray(a,lr_pnear(:,22),[],@nansum)];
[c,~,a]=unique(gfdl_pnear(:,1:2),'rows');
gfdl_NF_nux=[c,accumarray(a,gfdl_pnear(:,22),[],@nansum)];
[c,~,a]=unique(ec_pnear(:,1:2),'rows');
rec_NF_nux=[c,accumarray(a,ec_pnear(:,22),[],@nansum)];
[c,~,a]=unique(rhd_pnear(:,1:2),'rows');
rhd_NF_nux=[c,accumarray(a,rhd_pnear(:,22),[],@nansum)];
[c,~,a]=unique(rlr_pnear(:,1:2),'rows');
rlr_NF_nux=[c,accumarray(a,rlr_pnear(:,22),[],@nansum)];
% FF
[c,~,a]=unique(can_pfar(:,1:2),'rows');
can_FF_nux=[c,accumarray(a,can_pfar(:,22),[],@nansum)];
[c,~,a]=unique(hd_pfar(:,1:2),'rows');
hd_FF_nux=[c,accumarray(a,hd_pfar(:,22),[],@nansum)];
[c,~,a]=unique(lr_pfar(:,1:2),'rows');
lr_FF_nux=[c,accumarray(a,lr_pfar(:,22),[],@nansum)];
[c,~,a]=unique(gfdl_pfar(:,1:2),'rows');
gfdl_FF_nux=[c,accumarray(a,gfdl_pfar(:,22),[],@nansum)];
[c,~,a]=unique(ec_pfar(:,1:2),'rows');
rec_FF_nux=[c,accumarray(a,ec_pfar(:,22),[],@nansum)];
[c,~,a]=unique(rhd_pfar(:,1:2),'rows');
rhd_FF_nux=[c,accumarray(a,rhd_pfar(:,22),[],@nansum)];
[c,~,a]=unique(rlr_pfar(:,1:2),'rows');
rlr_FF_nux=[c,accumarray(a,rlr_pfar(:,22),[],@nansum)];


obs_sylhet = load('Sylhet_observed.txt');
monthly_corr = load('historical_sylhet.txt');
monthly_uncorr1 = load('2020_24_sylhet.txt');
monthly_uncorr2 = load('2025_29_sylhet.txt');

% nuxtcatch=[Time_obs,nuxtcatch];
[c,~,a]=unique(P2(:,1:2),'rows');
tmp1=[c,accumarray(a,P2(:,4),[],@sum)];
tmp1=tmp1(1:240,:);

% m1=mean(P(:,3));
% m2=mean(tmp1(:,3));
UDELdata= obs_sylhet;
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

m1=mean(monthly_corr);
m2=mean(monthly_corr1);
m3=mean(monthly_corr2);

[f3,x3] = ksdensity(P,'Function','cdf'); 
[f4,x4] = ksdensity(monthly_corr,'Function','cdf');
plot(f3,x3,'LineStyle','-','Color','green')
hold on
plot(f4,x4,'LineStyle','--','Color','magenta')

%%%%%%%%% new bc seroies






%% % Nux hist
[c,~,a]=unique(can_phist_bc(:,1:2),'rows');
can_hist_nux=[c,accumarray(a,can_phist_bc(:,22),[],@nansum)];
[c,~,a]=unique(hd_phist_bc(:,1:2),'rows');
hd_hist_nux=[c,accumarray(a,hd_phist_bc(:,22),[],@nansum)];
[c,~,a]=unique(lr_phist_bc(:,1:2),'rows');
lr_hist_nux=[c,accumarray(a,lr_phist_bc(:,22),[],@nansum)];
[c,~,a]=unique(gfdl_phist_bc(:,1:2),'rows');
gfdl_hist_nux=[c,accumarray(a,gfdl_phist_bc(:,22),[],@nansum)];
[c,~,a]=unique(ec_phist_bc(:,1:2),'rows');
rec_hist_nux=[c,accumarray(a,ec_phist_bc(:,22),[],@nansum)];
[c,~,a]=unique(rhd_phist_bc(:,1:2),'rows');
rhd_hist_nux=[c,accumarray(a,rhd_phist_bc(:,22),[],@nansum)];
[c,~,a]=unique(rlr_phist_bc(:,1:2),'rows');
rlr_hist_nux=[c,accumarray(a,rlr_phist_bc(:,22),[],@nansum)];
% NF
[c,~,a]=unique(can_pnear_bc(:,1:2),'rows');
can_NF_nux=[c,accumarray(a,can_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(hd_pnear_bc(:,1:2),'rows');
hd_NF_nux=[c,accumarray(a,hd_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(lr_pnear_bc(:,1:2),'rows');
lr_NF_nux=[c,accumarray(a,lr_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(gfdl_pnear_bc(:,1:2),'rows');
gfdl_NF_nux=[c,accumarray(a,gfdl_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(ec_pnear_bc(:,1:2),'rows');
rec_NF_nux=[c,accumarray(a,ec_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(rhd_pnear_bc(:,1:2),'rows');
rhd_NF_nux=[c,accumarray(a,rhd_pnear_bc(:,22),[],@nansum)];
[c,~,a]=unique(rlr_pnear_bc(:,1:2),'rows');
rlr_NF_nux=[c,accumarray(a,rlr_pnear_bc(:,22),[],@nansum)];
% FF
[c,~,a]=unique(can_pfar_bc(:,1:2),'rows');
can_FF_nux=[c,accumarray(a,can_pfar_bc(:,22),[],@nansum)];
[c,~,a]=unique(hd_pfar_bc(:,1:2),'rows');
hd_FF_nux=[c,accumarray(a,hd_pfar_bc(:,22),[],@nansum)];
[c,~,a]=unique(lr_pfar_bc(:,1:2),'rows');
lr_FF_nux=[c,accumarray(a,lr_pfar_bc(:,22),[],@nansum)];
[c,~,a]=unique(gfdl_pfar_bc(:,1:2),'rows');
gfdl_FF_nux=[c,accumarray(a,gfdl_pfar_bc(:,22),[],@nansum)];
[c,~,a]=unique(ec_pfar_bc(:,1:2),'rows');
rec_FF_nux=[c,accumarray(a,ec_pfar_bc(:,22),[],@nansum)];
[c,~,a]=unique(rhd_pfar_bc(:,1:2),'rows');
rhd_FF_nux=[c,accumarray(a,rhd_pfar_bc(:,22),[],@nansum)];
[c,~,a]=unique(rlr_pfar_bc(:,1:2),'rows');
rlr_FF_nux=[c,accumarray(a,rlr_pfar_bc(:,22),[],@nansum)];

