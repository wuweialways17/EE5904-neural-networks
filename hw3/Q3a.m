clc;
clear;

x = linspace(-pi,pi,400); 
trainX = [x; 2*sin(x)]; 

% SOM
weights = zeros(2,36);
sigma0 = sqrt(36^2+1)/2;
for epoch = 1:600
    lr = 0.1*exp(-epoch/600);
    sigma = sigma0*exp(-epoch/(600/log(sigma0)));
    for i = 1:size(trainX,2)
        dis = sum((trainX(:,i) - weights).^2,1);
        [~,winner] = min(dis,[],2);
        d = abs([1:36]-winner);
        h = exp(-d.^2/(2*sigma^2));
        weights = weights + lr*h.*(trainX(:,i) - weights);
    end
end

%plot
plot(trainX(1,:),trainX(2,:),'+r',weights(1,:),weights(2,:),'o-');
legend('tr','som');
