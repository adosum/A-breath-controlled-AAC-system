%% choose the reference patterns
sample{1}=z{1};         %z is The cell for the breath signal
sample{2}=z{18};
sample{3}=z{32};
sample{4}=z{46};
sample{5}=z{61};
sample{6}=z{76};
% sample{7}=z{92};
% sample{8}=z{106};
% sample{9}=z{122};
% sample{10}=z{140};
%% cal the cost with each reference signal
for j=1:90
    for i=1:6
    distance(i,j) = dtw(sample{i},z{j});
    end
end
%% choose the smallest cost as the class
for j=1:90
    [v,n(:,j)]=min(distance(:,j));
end
stem(n)  %show the result
