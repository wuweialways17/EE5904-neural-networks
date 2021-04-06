clc;
clear;
%My matric number is A0224454J
%choose classes 5 and 4

load('characters10.mat');
trainIdx = find(train_label==4 | train_label==5); 
trainY = train_label(trainIdx); 
TrLabel = zeros(size(trainY));
TrLabel(trainY==4) = 1;
TrLabel(trainY==5) = 0;
trainX = double(train_data(trainIdx,:)); 
TrData = zeros(size(trainX'));

%Z-score normalization
train_mean = mean(double(trainX(1,1:784)),2);
train_std = std(double(trainX(1,1:784)),1,2);
for i = 1:size(trainX,1)
    TrData(:,i) = (double(trainX(i,:)) - train_mean)./train_std;
end

testIdx = find(test_label==4 | test_label==5); 
testY = test_label(testIdx); 
TeLabel = zeros(size(testY));
TeLabel(testY==4) = 1;
TeLabel(testY==5) = 0;
testX = double(test_data(testIdx,:)); 
TeData = zeros(size(testX'));

%Z-score normalization
test_mean = mean(double(testX(1,1:784)),2);
test_std = std(double(testX(1,1:784)),1,2);
for i = 1:size(testX,1)
    TeData(:,i) = (double(testX(i,:)) - test_mean)./test_std;
end

sigma = 100;

%k-means
[Idx,centers]=kmeans(TrData',2); 

% visualization 
% subplot(1,2,1)
% imshow(reshape(centers(1,:),28,28));
% subplot(1,2,2)
% imshow(reshape(centers(2,:),28,28));

% TrData_ = TrData';
% mean_0 = zeros(1,784);
% mean_1 = zeros(1,784);
% for i = [1:600]
%     if TrLabel(i) == 0
%         mean_0 = (mean_0+TrData_(i,:))/2;
%     else
%         mean_1 = (mean_1+TrData_(i,:))/2;      
%     end
% end
% subplot(1,2,1)
% imshow(reshape(mean_1,28,28));
% subplot(1,2,2)
% imshow(reshape(mean_0,28,28));

% [coeff,score] = pca(TrData);
% X=score(:,:);
% [Idx,centers]=kmeans(X,2); 
% 
% figure();
% plot(X(Idx==1,1),X(Idx==1,2),'r.','MarkerSize',14)
% hold on
% plot(X(Idx==2,1),X(Idx==2,2),'b.','MarkerSize',14)
% plot(centers(:,1),centers(:,2),'kx','MarkerSize',14,'LineWidth',4)
% legend('Cluster 1','Cluster 2','Centroids')


% train
r = dist(TrData',centers');
i_matrix = exp(-r/(2*sigma^2));
w = pinv(i_matrix'*i_matrix)*i_matrix'*TrLabel;
TrPred = (i_matrix*w);

% test
r = dist(TeData',centers');
i_matrix = exp(-r/(2*sigma^2));
TePred = (i_matrix*w);

%plot
fig = figure();
TrAcc = zeros(1,1000);
TeAcc = zeros(1,1000);
thr = zeros(1,1000);
TrN = length(trainY);
TeN = length(testY);
for j = 1:1000
    t = (max(TrPred)-min(TrPred)) * (j-1)/1000 + min(TrPred);
    thr(j) = t;
    TrAcc(j) = (sum(TrLabel(TrPred<t)==0) + sum(TrLabel(TrPred>=t)==1)) / TrN;
    TeAcc(j) = (sum(TeLabel(TePred<t)==0) + sum(TeLabel(TePred>=t)==1)) / TeN;
end
plot(thr,TrAcc,'.- ',thr,TeAcc,'^-');legend('tr','te');



