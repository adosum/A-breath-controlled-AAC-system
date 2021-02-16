%% function to cal the cost between two signal
function dist = dtw(t,r)
n = size(t,1);
m = size(r,1);
d = zeros(n,m);
for i = 1:n
    for j = 1:m
        d(i,j) = (t(i,:)-r(j,:)).^2;
    end
end
D = ones(n,m) * realmax;
D(1,1) = d(1,1);
for i = 1:n
for j = 1:m
if i==1&&j==1
continue;
end
if i>1
D1 = D(i-1,j);
else
D1 = realmax;
end
if j>1&&i>1
D2 = 2*D(i-1,j-1); 
else D2 = realmax;
end 
if j>1
D3 = D(i,j-1);
else
D3 = realmax;
end
D(i,j) = d(i,j) + min([D1,D2,D3]);
end
end
dist = D(n,m);