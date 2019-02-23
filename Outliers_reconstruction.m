% import data from excel table
% the data structure is,
% col_1     col_2     col_3
%  X[s]       T[s]       P[w]
data = xlsread('Leistung_AC.xlsx');
L = length(data);
power = data(:,3);

%% set parameters
% global tuning parameter
threshold = 50;

%% preprocessing to dataset using mean
% no algorithmus Sampling at 1 minute( 6000[ms] )
integer_num = floor(L/6000);
mod_num = mod(L,6000);

integer_matrix = reshape(power(1:end-mod_num),6000,integer_num);
mod_matrix = power(end-mod_num+1:end);

integer_mean = mean(integer_matrix); 
mod_mean = mean(mod_matrix);

power_downsampling = [integer_mean mod_mean]';

%% Part one: Changing threshold
% initialisation 
x1  = power_downsampling(1);
outlier_index = [];

% iterator
for i=2:length(power_downsampling)

    x2 = power_downsampling(i);
    if abs(x1-x2) > threshold
        x1 = x2;
        outlier_index(end+1)=i;
    end
    
end

%% plot outliers
outlier_list = power_downsampling(outlier_index);
plot(power_downsampling,'.-');
hold on;
plot(outlier_index',outlier_list','x-');
legend('original data','outlier');
xlabel('Time[minute]');
ylabel('Power[w]');


