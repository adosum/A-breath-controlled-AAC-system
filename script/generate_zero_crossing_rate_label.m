clc
clear
close all
load traindata1 

%% cross zero rate
z = zeros(10,90);
for j=1:90
A = smooth(traindata1(:,j));  % smooth with a moving average filter (5)
msig = median(A);
A = A-msig; 
Max = max(A);
Thr = abs(A) >= (0.1*Max);
A = A.*Thr;
y = zeros(10,1);
a = 1;
for i=1:100:901
xx = A(i:99+i);    
y(a) = sum(abs(diff(xx>0)));
a = a+1;
end
z(:,j)=y;
end


%% layble
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
for i=1:10
    z(11,i+60) = 7;
end
for i=1:10
    z(11,(i+70)) = 8;
end
for i=1:10
    z(11,(i+80)) = 9;
end
for i=1:10
    z(11,i+90) = 10;
end
%% nnlabel
for i=1:15
    zl(1,i) = 1;
end
for i=1:15
    zl(2,(i+15)) = 1;
end
for i=1:15
    zl(3,(i+30)) = 1;
end
for i=1:15
    zl(4,i+45) = 1;
end
for i=1:15
    zl(5,(i+60)) = 1;
end
for i=1:15
    zl(6,(i+75)) = 1;
end
for i=1:15
    zl(7,i+90) = 1;
end
for i=1:15
    zl(8,(i+105)) = 1;
end
for i=1:15
    zl(9,(i+120)) = 1;
end
for i=1:15
    zl(10,i+135) = 1;
end

for i=1:5
    zl(1,i) = 1;
end
for i=1:5
    zl(2,(i+5)) = 1;
end
for i=1:5
    zl(3,(i+10)) = 1;
end
for i=1:5
    zl(4,i+15) = 1;
end
for i=1:5
    zl(5,(i+20)) = 1;
end
for i=1:5
    zl(6,(i+25)) = 1;
end
for i=1:5
    zl(7,i+30) = 1;
end
for i=1:5
    zl(8,(i+35)) = 1;
end
for i=1:5
    zl(9,(i+40)) = 1;
end
for i=1:5
    zl(10,i+45) = 1;
end