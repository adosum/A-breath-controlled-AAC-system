clc
clear
close all
load traindata1
load testdata1
load traindata2
%% cross zero rate
z = zeros(10,150);
for j=1:150
A = smooth(traindata1(:,j));  % smooth with a moving average filter (5)
msig = median(A);
A = A-msig; 
Max = max(A);
Thr = abs(A) >= (0.1*Max);   %threshold for the breath signal
A = A.*Thr;
len = length(A);
cnt = 1;
a=1;
label = 1;
A(1000)=0.1;                %for count label sign, to distinguish two patterns
for i=1:1:len               %detect all the index shows the segmentation
     if A(i) == 0
         cnt=cnt+1;
     end
     if A(i) ~= 0
         if cnt>150         % count number to decide the pulse
            label(a)=i-cnt+1;
            a=a+1;
            label(a)=i-1;
            a=a+1;
            cnt = 1;
         end
         cnt=1;
     end
end
label = [1,label];
len=length(label);
for i=1:1:len-1                     % decide the segmentation is a breath pattern    
    if sum(A(label(i):label(i+1)))~=0
        aa = A(label(i):label(i+1));
        if max(aa)>0.5*Max
            aa(length(aa):1000) = 0;  %unify the length
            data = aa;
        end
    end
end
aa = A(label(len):(length(A)-1));   %select the last index detected to the end
if max(aa)>0.5*Max
    aa(length(aa):1000) = 0;        % unify the length
    data = aa;
end
label = 1;
for i=1:149                         % makes the breath singal start from the begining
    if data(2)==0
        data = circshift(data,-1);
    end
end
y = zeros(10,1);
a = 1;
for i=1:100:901                     % cal the zero cross rate
xx = data(i:99+i);    
y(a) = sum(abs(diff(xx>0)));
a = a+1;
end
z(:,j)=y;
% z{j}=data;
end
%% cut continues breath signal input
% A = traindata2(:,1);
% A(1001:2000)=traindata2(:,11);
% A = smooth(A);          % smooth with a moving average filter (5)
% msig = median(A);
% A = A-msig; 
% Max = max(A);
% Thr = abs(A) >= (0.1*Max);
% A = A.*Thr;
% len = length(A);
% cnt = 1;
% a=1;
% label = 1;
% for i=1:1:len
%      if A(i) == 0
%          cnt=cnt+1;
%      end
%      if A(i) ~= 0
%          if cnt>150         % count number to decide the pulse
%             label(a)=i-cnt+1;
%             a=a+1;
%             label(a)=i-1;
%             a=a+1;
%             cnt = 1;
%          end
%          cnt=1;
%      end
% end
% label = [1,label];
% len=length(label);
% a=1;
% cnt1=1;
% for i=1:1:len-1
%     if sum(A(label(i):label(i+1)))~=0
%         aa = A(label(i):label(i+1));
%         if max(aa)>0.5*Max
%             aa(length(aa):1000) = 0; % unify the length
%             data{a}=aa;              % obtain the data
%             a=a+1;
%         end
%     end
% end
% aa = A(label(len):(length(A)-1));
% if max(aa)>0.5*Max
%      aa(length(aa):1000) = 0;
%     data{a} = aa;
% end
% for i=1:150  % shift the signal, to make it start from begining 
%     if data{1}(2)==0
%         data{1} = circshift(data{1},-1);
%     end
% end
% figure
% plot(data{1})
% figure 
% plot(data{2})