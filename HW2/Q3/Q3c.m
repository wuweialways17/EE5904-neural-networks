clc;
clear;
%My matric number is A0224454J
%Mod(54,3)+1 = 1

new_size = [50 50];

train_imgs = [];
train_label = [];
img_file = dir(fullfile('Face_Database/TrainImages','*.jpg'));
label_file = dir(fullfile('Face_Database/TrainImages','*.att'));

for i = 1:1000
    I = imread(append('Face_Database/TrainImages/',img_file(i).name));
    I = imresize(I,new_size);
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
    I = imresize(I,new_size);
    G=rgb2gray(I);
    V = double(G(:));
    test_imgs = [test_imgs V];
    L =load(append('Face_Database/TestImages/',label_file(i).name));
    l = double(L(1));
    test_label = [test_label l];
end


%net
net = perceptron();
net = configure(net,train_imgs,train_label);
net.trainparam.lr=0.001;
net.trainparam.epochs=500;
net.trainparam.goal=1e-5;
net.divideFcn = 'dividetrain';
% Train the perceptron
[net,tr]=train(net,train_imgs,train_label);
% accuracy
train_pred = net(train_imgs);
train_acc = 1 - mean(abs(train_pred-train_label));
test_pred = net(test_imgs);
test_acc = 1 - mean(abs(test_pred-test_label));
fprintf('train_acc: %0.2f%%\n',train_acc*100)
fprintf('test_acc: %0.2f%%\n',test_acc*100)



