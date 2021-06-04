% grafici per validation phase
addpath('/home/terri/Documenti/UNIVERSITA/NUM2/progetto/gitcode/lattice_materials/tests')
addpath('/home/terri/Documenti/UNIVERSITA/NUM2/progetto/gitcode/lattice_materials/tests/tensile_non_linear_KS')
linear = readtable('tensile_linear.csv');
nl_FF = readtable('tensile_non_linear_FF.csv');
nl_KS = readtable('linear_consistency.csv');
newton_conv = readtable('newton_convergence.csv');

x = table2array(nl_FF(:,3));
y = table2array(nl_FF(:,2));
figure()
plot(x,y, 'o-', 'linewidth', 2)
title('FreeFem non-linear model')
xlabel('nl')
ylabel('Poisson coeff. nu')

clear x
clear y

x = table2array(nl_KS(:,1));
y = table2array(nl_KS(:,2));
figure()
plot(x,y, 'o-', 'linewidth', 2)
title('KS non-linear model')
xlabel('d1')
ylabel('Poisson coeff. nu')

clear x
clear y

x = table2array(linear(:,1));
y1 = table2array(linear(:,2));
y2 = table2array(linear(:,3));
figure()
plot(x,y1, 'o-', 'linewidth', 2)
hold on
plot(x,y2, '*-', 'linewidth', 2)
title('linear - convect vs borders average')
xlabel('d1')
ylabel('Poisson coeff. nu')
legend('convect', 'border')

clear x
clear y1
clear y2
%% Newton's convergence test

y1 = table2array(newton_conv(1:6,1));
y2 = table2array(newton_conv(7:11,1));
y3 = table2array(newton_conv(12:16,1));
y4 = table2array(newton_conv(17:21,1));
y5 = table2array(newton_conv(22:25,1));
y6 = table2array(newton_conv(26:29,1));
y7 = table2array(newton_conv(30:33,1));

ord1 = y1(2:end) ./ (y1(1:end-1).^2) ;
figure()
