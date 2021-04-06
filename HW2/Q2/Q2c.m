clc;
clear;

x_train=-2:0.05:2;
y_train=1.2*sin(pi*x_train) - cos(2.4*pi*x_train);

x_test=-3:0.01:3;
y_test=1.2*sin(pi*x_test) - cos(2.4*pi*x_test);


for n = [1:10 20 50 100]
net = feedforwardnet(n,'trainbr');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net,x_train,y_train);
net.trainparam.lr=0.001;
net.trainparam.epochs=1000;
net.trainparam.goal=1e-5;
net.divideFcn = 'dividetrain';
[net,tr]=train(net,x_train,y_train);


fig = figure();
y_pred = sim(net,x_test);
plot(x_test,y_test,'o', x_test,y_pred);
xlabel('x');
ylabel('y');
title('MLP fitting result')
%saveas(fig,sprintf('resultc/%d neurons.png',n));

end
