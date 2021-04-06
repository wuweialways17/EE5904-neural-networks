% clc;
% clear;
% %My matric number is A0224454J
% %ignore classes 5 and 4
% 
% load('characters10.mat');
% trainIdx = find(train_label~=4 & train_label~=5); 
% TrLabel = train_label(trainIdx); 
% X = double(train_data(trainIdx,:)); 
% Train_Data = X;
% 
% [row,column] = size(Train_Data);
% m=10;
% n=10;
% neurons = m*n;
% weights = rand(neurons,column);
% sigma0 = sqrt(10^2+10^2)/2;
% [I,J] = ind2sub([m,n],1:neurons); 
% 
% for epoch = 1:1000
%     lr = 0.1*exp(-epoch/1000);
%     sigma = sigma0*exp(-epoch/(1000/log(sigma0)));
% 	for i = 1:row
% 		[~,winIdx] = min(dist(Train_Data(i,:),weights'));
% 		[winrow,wincolumn] = ind2sub([m,n],winIdx);
% 		win = [winrow,wincolumn];
% 		d = exp(-sum(([I(:) J(:)] - repmat(win,neurons,1)).^2,2)/(2*sigma^2));
% 		for j = 1:neurons
% 			weights(j,:) = weights(j,:) + lr*d(j).*(Train_Data(i,:) - weights(j,:));
% 		end
% 	end
% end
% 
% 
% for n = 1:10
%     for k = 1:10
%         subplot(10,10,(n-1)*10+k)
%         imshow(reshape(weights((n-1)*10+k,:),28,28))
%     end
% end
dis = [];
for i=[1:400]
if pred_y(1,i)~=testY(i,1)
    dis=[dis;pred_y(1,i),testY(i,1)];
end
end
