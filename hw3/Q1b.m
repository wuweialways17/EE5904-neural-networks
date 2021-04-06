clc;
clear;

x_train = -1:0.05:1;
y_train = 1.2*sin(pi*x_train)-cos(2.4*pi*x_train)+0.3*randn(1,41);

x_test = -1:0.01:1;
y_test = 1.2*sin(pi*x_test)-cos(2.4*pi*x_test);

sigma = 0.1;
% randomly select 20 centers among the sampling points
centers = datasample(x_train,20,2);

% train
r = abs(x_train' - centers);
i_matrix = exp(-r.^2./(2*sigma^2));
w = pinv(i_matrix)*y_train';

% test
r = abs(x_test' - centers);
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
