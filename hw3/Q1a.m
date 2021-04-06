clc;
clear;

x_train = -1:0.05:1;
y_train = 1.2*sin(pi*x_train)-cos(2.4*pi*x_train)+0.3*randn(1,41);

x_test = -1:0.01:1;
y_test = 1.2*sin(pi*x_test)-cos(2.4*pi*x_test);

sigma = 0.1;
% train
r = abs(x_train' - x_train);
i_matrix = exp(-r.^2./(2*sigma^2));
w = i_matrix^-1*y_train';

% test
r = abs(x_test' - x_train);
i_matrix = exp(-r.^2./(2*sigma^2));
y_pred = (i_matrix*w)';
test_mse = sum((y_pred - y_test).^2)/201;

% plot
fig = figure();
plot(x_test,y_test,'o', x_test,y_pred);
xlabel('x');
ylabel('y');
title('RBFN fitting result')

% MSE
fprintf('test_mse: %0.2f%\n',test_mse)
