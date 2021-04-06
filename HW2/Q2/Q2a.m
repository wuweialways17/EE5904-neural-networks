clc;
clear;

x_train=-2:0.05:2;
y_train=1.2*sin(pi*x_train) - cos(2.4*pi*x_train);

x_test=-3:0.01:3;
y_test=1.2*sin(pi*x_test) - cos(2.4*pi*x_test);

for n = [1:10 20 50 100]
net = feedforwardnet(n);
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net, x_train, y_train); 
    for epoch = 1: 500
    idx = randperm(length(x_train));
    net = adapt(net, x_train(:,idx), y_train(:,idx));
    end
    
fig = figure();
y_pred = sim(net,x_test);
plot(x_test,y_test,'o', x_test,y_pred);
xlabel('x');
ylabel('y');
title('MLP fitting result')
%saveas(fig,sprintf('resulta/%d neurons.png',n));

end



