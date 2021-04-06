clc;
clear;
%My matric number is A0224454J
%Mod(54,3)+1 = 1

train_imgs = [];
train_label = [];
img_file = dir(fullfile('Face_Database/TrainImages','*.jpg'));
label_file = dir(fullfile('Face_Database/TrainImages','*.att'));

for i = 1:1000
    I = imread(append('Face_Database/TrainImages/',img_file(i).name));
    I = imresize(I,[101 101]);
    G=rgb2gray(I);
    V = double(G(:));  
    train_imgs = [train_imgs V];
    L =load(append('Face_Database/TrainImages/',label_file(i).name));
    l = double(L(1));
    train_label = [train_label l];
end
    
test_imgs = [];
test_label = [];
img_file = dir(fullfile('Face_Database/TestImages','*.jpg'));
label_file = dir(fullfile('Face_Database/TestImages','*.att'));

for i = 1:250
    I = imread(append('Face_Database/TestImages/',img_file(i).name));
    I = imresize(I,[101 101]);
    G=rgb2gray(I);
    V = double(G(:));
    test_imgs = [test_imgs V];
    L =load(append('Face_Database/TestImages/',label_file(i).name));
    l = double(L(1));
    test_label = [test_label l];
end

%net
net = patternnet(256);
net.divideFcn = 'dividetrain';         
net = configure(net, train_imgs, train_label); 
train_acc_array = [];
test_acc_array = [];
    for epoch = 1: 500
    idx = randperm(1000);
    net = adapt(net, train_imgs(:,idx), train_label(:,idx));
    % accuracy
    train_pred = net(train_imgs);
    train_acc = 1 - mean(abs(train_pred-train_label));
    train_acc_array = [train_acc_array, train_acc];
    test_pred = net(test_imgs);
    test_acc = 1 - mean(abs(test_pred-test_label));
    test_acc_array = [test_acc_array, test_acc];
    end


fig = figure();
epochs = [1:500];
plot(epochs,train_acc_array, epochs,test_acc_array);
grid on;
legend('train_acc','test_acc');
xlabel('epoch');
ylabel('accuracy');
title('MLP performance');