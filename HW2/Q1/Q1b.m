clc;
clear;

x = rand(1);
y = rand(1);
f = (1-x)^2 + 100*(y-x^2)^2;
xy_record = [x,y;]; 
f_record = [f]; 
iter = 0;
iter_list = [0];


while f >= 1e-5
    H = [1200*x^2 - 400*y + 2,-400*x; -400*x,200];
    g = [(2*(x - 1) + 400*(x^3 - x*y)); 200*(y-x^2)];
    w = [x;y]-H^(-1)*g;
    x = w(1);
    y = w(2);
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