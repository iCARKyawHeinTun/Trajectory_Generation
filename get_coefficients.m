function [coff, A, b] = getCoff(waypoints)
n = size(waypoints,1)-1; % number of segments P1..n
A = zeros(8*n, 8*n);
b = zeros(1,8*n);

% --------------------------------------------

% YOUR CODE HERE 
% Fill A and b matices with values using loops

% Example for first 4 equations:

for i=1:n
    b(1,i) = waypoints(i);
end

row = 1;
for i=1:n
    A(row,8*(i-1):8*i) = polyT(8,0,0); 
    row = row + 1;
end

% --------------------------------------------

coff = inv(A)*b';
end