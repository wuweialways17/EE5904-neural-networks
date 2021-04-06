clc;
clear;

X = randn(800,2); 
s2 = sum(X.^2,2); 
trainX = (X.*repmat(1*(gammainc(s2/2,1).^(1/2))./sqrt(s2),1,2)); 

% SOM
[row,column] = size(trainX);
m=6;
n=6;
neurons = m*n;
weights = rand(neurons,column);
sigma0 = sqrt(6^2+6^2)/2;
[I,J] = ind2sub([m,n],1:neurons); 

for epoch = 1:2000
    lr = 0.1*exp(-epoch/2000);
    sigma = sigma0*exp(-epoch/(2000/log(sigma0)));
	for i = 1:row
		[~,winIdx] = min(dist(trainX(i,:),weights'));
		[winrow,wincolumn] = ind2sub([m,n],winIdx);
		win = [winrow,wincolumn];
		d = exp(-sum(([I(:) J(:)] - repmat(win,neurons,1)).^2,2)/(2*sigma^2));
		for j = 1:neurons
			weights(j,:) = weights(j,:) + lr*d(j).*(trainX(i,:) - weights(j,:));
		end
	end

end


%plot
figure();
plot(trainX(:,1),trainX(:,2),'+r'); 
hold on;
for i = 0:5
    plot(weights(i*6+1:(i+1)*6,1),weights(i*6+1:(i+1)*6,2),'o-');
end
hold on;
for i = 1:6
    plot(weights(i:6:i+30,1),weights(i:6:i+30,2),'o-');
end
hold off;
legend('tr','som');