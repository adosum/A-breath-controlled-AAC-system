for i = 1:1:9
    k = 40+i;
    k = num2str(k);
    traindata(:,(i+110)) = csvread(k);
end
% for i = 10:1:40
%     k = 400+i;
%     k = num2str(k);
%     traindata(:,(i+110)) = csvread(k);
% end

traindata(:,120) = csvread('410');
for i = 1:1:9
    k = i+140;
    k = num2str(k);
    testdata(:,i) = csvread(k);
end
for i = 1:1:9
    k = i+240;
    k = num2str(k);
    testdata(:,(i+10)) = csvread(k);
end
for i = 1:1:9
    k = i+340;
    k = num2str(k);
    testdata(:,(i+20)) = csvread(k);
end
for i = 1:1:5
    k = i+410;
    k = num2str(k);
    testdata(:,(i+30)) = csvread(k);
end
% digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos',...
%     'nndatasets','DigitDataset');
% digitData = imageDatastore(digitDatasetPath,...
%         'IncludeSubfolders',true,'LabelSource','foldernames');