clc;
clear;
%My matric number is A0224454J
%ignore classes 5 and 4

load('characters10.mat');
trainIdx = find(train_label~=4 & train_label~=5); 
trainY = train_label(trainIdx);
trainX = train_data(trainIdx,:);
TrData = zeros(size(trainX));

%Z-score normalization
train_mean = mean(double(trainX(1,1:784)),2);
train_std = std(double(trainX(1,1:784)),1,2);
for i = 1:size(trainX,1)
    TrData(i,:) = (double(trainX(i,:)) - train_mean)./train_std;
end

testIdx = find(test_label~=4 & test_label~=5); 
testY = test_label(testIdx);
testX = test_data(testIdx,:);
TeData = zeros(size(testX));

%Z-score normalization
test_mean = mean(double(testX(1,1:784)),2);
test_std = std(double(testX(1,1:784)),1,2);
for i = 1:size(testX,1)
    TeData(i,:) = (double(testX(i,:)) - test_mean)./test_std;
end

%SOM
[weights,pred] = SOM(TrData,trainY);

%plot
for i = 1:100
    subplot(10,10,i);
    imshow(reshape(weights(i,:),[28 28]));
end

for k = 1:size(TeData,1)
    for r = 1:size(weights,1)
        D(r) = (weights(r,:) - TeData(k,:))*(weights(r,:) - TeData(k,:))';
    end
    point = find(D==min(D));
    pred_y(k) = pred(point);
end


% accuracy 
test_acc = sum(pred_y(:)==testY(:))/length(testY);
fprintf('test_acc: %0.2f%%\n',test_acc*100)

%error 
dis = [];
for i=[1:400]
if pred_y(1,i)~=testY(i,1)
    dis=[dis;pred_y(1,i),testY(i,1)];
end
end
