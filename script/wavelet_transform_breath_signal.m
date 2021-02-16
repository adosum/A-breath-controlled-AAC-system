clc
clear
% close all
load traindata2 
load testdata1
%% generate the training and testing set
zz = cell(1,50);
[N,M] = size(testdata1);    %traindata2 is for training set
for j=1:50
A = smooth(testdata1(:,j));  % smooth with a moving average filter (5)
msig = median(A);
A = A-msig;             % subtract median of signal to remove offset
B = cwt(A,1:256,'db2'); % Calculate wavelet transform data
T = 50;  % threshold at 50% of maximum peak
B = abs(B);
Size = size(B);
Max = max(max(B));
Thr = B >= (T*Max/100);
C = B.*Thr;
C = imresize(C,0.2);  % resize the image to adjust input for neural network
zz{j}=C;
end
%% label the training classes
for i=1:10
    ztrain(1,i) = 1;
end
for i=1:10
    ztrain(2,(i+10)) = 1;
end
for i=1:10
    ztrain(3,(i+20)) = 1;
end
for i=1:10
    ztrain(4,i+30) = 1;
end
for i=1:10
    ztrain(5,(i+40)) = 1;
end
for i=1:10
    ztrain(6,(i+50)) = 1;
end
for i=1:10
    ztrain(7,(i+60)) = 1;
end
for i=1:10
    ztrain(8,i+70) = 1;
end
for i=1:10
    ztrain(9,(i+80)) = 1;
end
for i=1:10
    ztrain(10,(i+90)) = 1;
end
%% first layer
rng('default')
hiddenSize1 = 1000;
autoenc1 = trainAutoencoder(z,hiddenSize1, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.004, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.15, ...
    'ScaleData', false, ...
    'UseGPU', false);
hiddenSize2 = 500;
feat1 = encode(autoenc1,z);
%% second layer
autoenc2 = trainAutoencoder(feat1,hiddenSize2, ...
    'MaxEpochs',400, ...
    'L2WeightRegularization',0.002, ...
    'SparsityRegularization',4, ...
    'SparsityProportion',0.1, ...
    'ScaleData', false);
feat2 = encode(autoenc2,feat1);
%% final net
softnet = trainSoftmaxLayer(feat2,ztrain,'MaxEpochs',400);  
deepnet = stack(autoenc1,autoenc2,softnet);
view(deepnet)
%% test
zztest = zeros(10400,numel(zz));
for i = 1:numel(zz)
    zztest(:,i) = zz{i}(:);
end
 y = deepnet(zztest);
plotconfusion(ztest,y);
 %% fine tuning dnn
zztrain = zeros(10400,numel(z));
for i = 1:numel(z)
    zztrain(:,i) = z{i}(:);
end
deepnet = train(deepnet,zztrain,ztrain); % Perform fine tuning
