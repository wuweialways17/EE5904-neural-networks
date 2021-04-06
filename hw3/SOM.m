function [weights,pred]= SOM(data,label)

[row,column] = size(data);
m=10;
n=10;
neurons = m*n;
weights = rand(neurons,column);
[I,J] = ind2sub([m,n],1:neurons); 
sigma0 = sqrt(10^2+10^2)/2;

for epoch = 1:3000
    %sigma = sigma0*exp(-epoch*log10(sigma0)/2000);
    sigma = sigma0*exp(-epoch/(3000/log(sigma0)));
    lr = 0.1*exp(-epoch/3000);
	for i = 1:row
		[~,winIdx] = min(dist(data(i,:),weights'));
		[winrow,wincolumn] = ind2sub([m,n],winIdx);
		win = [winrow,wincolumn];
		d = exp(-sum(([I(:) J(:)] - repmat(win,neurons,1)).^2,2)/(2*sigma^2));
		for j = 1:neurons
			weights(j,:) = weights(j,:) + lr*d(j).*(data(i,:) - weights(j,:));
		end
    end
end

for k = 1:neurons
    for r = 1:row
        D(r) = (weights(k,:) - data(r,:))*(weights(k,:) - data(r,:))';
    end
    point = D==min(D);
    pred(k) = label(point);
end
