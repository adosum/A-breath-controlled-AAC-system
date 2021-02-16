clc
clear
close all
load traindata2
load testdata1
%% cross zero rate
z = zeros(10,60);
for j=1:60
A = smooth(traindata2(:,j));  % smooth with a moving average filter (5)
msig = median(A);
A = A-msig; 
Max = max(A);
Thr = abs(A) >= (0.1*Max);
A = A.*Thr;
y = zeros(10,1);
a = 1;
for i=1:100:901
xx = A(i:99+i,:);    
y(a) = sum(abs(diff(xx>0)));
a = a+1;
end
z(:,j)=y;
end

for j=1:30
A = smooth(testdata1(:,j));  % smooth with a moving average filter (5)

msig = median(A);
A = A-msig; 
Max = max(A);
Thr = abs(A) >= (0.1*Max);
A = A.*Thr;

y = zeros(10,1);
a = 1;
for i=1:100:901
xx = A(i:99+i,:);    
y(a) = sum(abs(diff(xx>0)));
a = a+1;
end
zz(:,j)=y;
end
%% spectral flux
% xx = fft(x);
% for i = 2:256
% yy = (xx(i)-xx(i-1))^2;
% end
% plot(yy);
%% layble
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
for i=1:5
          ztest(1,i) = 1;
      end
        for i=1:5
          ztest(2,(i+5)) = 1;
        end
        for i=1:5
          ztest(3,(i+10)) = 1;
        end
        for i=1:5
          ztest(4,i+15) = 1;
      end
        for i=1:5
          ztest(5,(i+20)) = 1;
        end
        for i=1:5
          ztest(6,(i+25)) = 1;
        end
        
%% label
for i=1:10
    z(11,i) = 1;
end
for i=1:10
    z(11,(i+10)) = 2;
end
for i=1:10
    z(11,(i+20)) = 3;
end
for i=1:10
    z(11,i+30) = 4;
end
for i=1:10
    z(11,(i+40)) = 5;
end
for i=1:10
    z(11,(i+50)) = 6;
end
        
        %% net
% setdemorandstream(491218382);
% net = patternnet(8,'trainscg','crossentropy');
% 
% [net,tr] = train(net,z,ztrain);
% nntraintool
% y=net(zz);
% plotconfusion(ztest,y);
% subplot(2,3,1);plot(testdata1(:,11));
% subplot(2,3,2);plot(testdata1(:,2));
% subplot(2,3,3);plot(testdata1(:,1));
% subplot(2,3,4);plot(zz(:,11));
% subplot(2,3,5);plot(zz(:,2));
% subplot(2,3,6);plot(zz(:,1));

for i = 1:20
    subplot(4,5,i);
    plot(zz(:,i));
end