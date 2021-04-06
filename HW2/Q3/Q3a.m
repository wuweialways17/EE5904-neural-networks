clc;
clear;
%My matric number is A0224454J
%Mod(54,3)+1 = 1

train_label = [];
label_file = dir(fullfile('Face_Database/TrainImages','*.att'));

for i = 1:1000
    L =load(append('Face_Database/TrainImages/',label_file(i).name));
    l = L(1);
    train_label = [train_label l];
end

test_label = [];
label_file = dir(fullfile('Face_Database/TestImages','*.att'));

for i = 1:250
    L =load(append('Face_Database/TestImages/',label_file(i).name));
    l = L(1);
    test_label = [test_label l];
end

%plot
train_1 = sum(train_label)/1000;
train_0 =1 - train_1;
test_1 = sum(test_label)/250;
test_0 = 1 - test_1;


y=[train_0 train_1;test_0 test_1;];
b=bar(y);
grid on;
legend('label=0','laebl=1');
set(gca,'XTickLabel',{'train','test'})

