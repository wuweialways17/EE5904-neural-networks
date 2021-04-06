clc;
clear;

lr = 0.001; 
%lr = 0.5;

x = rand(1);
y = rand(1);
f = (1-x)^2 + 100*(y-x^2)^2;
xy_record = [x,y;]; 
f_record = [f]; 
iter = 0;
iter_list = [0];

while f >= 1e-5
    x = x - lr*(2*(x - 1) + 400*x*(x^2 - y));
    y = y - lr*(200*(y - x^2));
    f = (1-x)^2 + 100*(y-x^2)^2;
    xy_record = [xy_record;x,y;];
    f_record = [f_record;f];
    iter = iter + 1;
    iter_list = [iter_list;iter];
end

% plot
figure(1);
plot(xy_record(:,1),xy_record(:,2));
xlabel('x');
ylabel('y');
title('trajectory of (x,y)')

figure(2);
plot(iter_list,f_record);
xlabel('iter');
ylabel('f_value');
title('function value ')