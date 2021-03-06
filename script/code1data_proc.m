% Breath Data processing February 2015
% David Kerr February 2015, modified October 2016
% ******************************************************************
% Sample files generated by DK using breathing rig with sample rate
% of 100 Hz over a 10 second window. All four samples in code1data
% are of the same breathing sequence "word"
% ******************************************************************
% Peaks are thresholded at 50% of largest value (T)
% Areas are thrersholded at 10% of largest value (Ta)

clear all
close all

load traindata2               %raw data file with 4 samples
[N,M] = size(traindata2);

A = smooth(traindata2(:,1));  % smooth with a moving average filter (5)
A = filter([1 -0.95],1,A);
A = smooth(A);
msig = median(A);
A = A-msig;             % subtract median of signal to remove offset

%       Calculate wavelet transform data:
B = cwt(A,1:256,'db2'); % Calculate wavelet transform data

%       Time Domain Plot:
time = 0:0.01:9.99;       % 1000 samples over a 10 second window

figure; plot(time,A,'black')
xlabel('Time (Seconds)')
ylabel('Pressure (mBar)')
title('Pressure-Time Graph')

% Threshold Wavelet for "Peaks of Significance"
T = 50;  % threshold at 50% of maximum peak
B = abs(B);
Size = size(B);
Max = max(max(B));
Thr = B >= (T*Max/100);
C = B.*Thr;
figure; imagesc(C)

% Now find the cwt peaks from the thresholded data and output the scales
% and times at which they occur
mxc = max(max(C));
C = C*(255/mxc);
figure; imshow(C,[])
BW = C>0;
s = regionprops(BW, C, {'WeightedCentroid','Area'});
Ta = max([s.Area])*0.01;  %area minimum limit is 10% of largest blob
k = numel(s);
result = zeros(k,3); count=1;
hold on
clc; fprintf('Time(s)  Scale  Area\n')
for i=1:k
    pktime = (s(i).WeightedCentroid(1)/1000) * 10;
    pkscale = s(i).WeightedCentroid(2);
    parea = s(i).Area;
    if parea >= Ta
       fprintf('    %4.1f    %4.1f   %i\n', pktime, pkscale, parea)
       plot(s(i).WeightedCentroid(1), s(i).WeightedCentroid(2), 'r*');
       result(count,:) = [pktime pkscale parea];
       count = count+1;
    end
end
title('Thresholded peaks in cwt space')
xlabel('Time (10 second window)')
ylabel('Wavelet Scale')
hold off


%%


A = smooth(traindata2(:,1));  % smooth with a moving average filter (5)
A = filter([1 -0.95],1,A);
A = smooth(A);
msig = median(A);
A = A-msig;             % subtract median of signal to remove offset

%       Calculate wavelet transform data:
B = cwt(A,1:256,'db2'); % Calculate wavelet transform data

%       Time Domain Plot:
time = 0:0.01:9.99;       % 1000 samples over a 10 second window

figure; plot(time,A,'black')
xlabel('Time (Seconds)')
ylabel('Pressure (mBar)')
title('Pressure-Time Graph')