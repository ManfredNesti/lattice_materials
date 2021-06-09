clear all
close all
clc

%%
addpath("tensile_nonlinear_KS");
linear = readtable('tensile_linear.csv');
nl_FF = readtable('tensile_nonlinear_FF.csv');
nl_KS = readtable('tensile_nonlinear_KS/linear_consistency.csv');
newton_conv = readtable('tensile_nonlinear_KS/newton_convergence.csv');

%% FreeFem++ nonlinear model
x = table2array(nl_FF(:,3));
y = table2array(nl_FF(:,2));
figure()
plot(x,y, 'o-', 'linewidth', 2)
title('FreeFem++ nonlinear model')
xlabel('nl')
ylabel('\nu')

saveas(gcf,'linear','png')

clear x
clear y

%% KS nonlinear model
x = table2array(nl_KS(:,1));
y = table2array(nl_KS(:,2));
figure()
plot(x,y, 'o-', 'linewidth', 2)
title('KS nonlinear model')
xlabel('d_1')
ylabel('\nu')

saveas(gcf,'KS_nl','png')

clear x
clear y

%% Linear model
x = table2array(linear(:,1));
y1 = table2array(linear(:,2));
y2 = table2array(linear(:,3));
figure()
plot(x,y1, 'o-', 'linewidth', 2)
hold on
plot(x,y2, '*-', 'linewidth', 2)
title('Linear model: convect vs borders average')
xlabel('d1')
ylabel('\nu')
legend('Convect', 'Border')

saveas(gcf,'FF_nl','png')

clear x
clear y1
clear y2