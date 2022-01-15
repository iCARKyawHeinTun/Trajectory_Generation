n = 4;  %size(points,1)-1; % number of segments P1..n    % % Number of polynomials // four polynomials // four sigments

A = zeros(8*n, 8*n); %% matrix for coefficients // four polynomials --> 4 * 8 = 32 constants for position // 32 rows and 32 columns

b = zeros(1,8*n);

row = 1;

%row 1 P1(0) = W1

A(row,1:8) = polyT(8,0,0);                      %% coefficients for first polynomial  --> from first to second point

b(1,row) = points(1,1);                         %% x coordinate of I point

row = row+1;

%row 2 P2(0) = W2

A(row,9:16) = polyT(8,0,0);                     %% coefficients for second polynomial --> from second to third point

b(1,row) = points(1,2);                         %% x coordinate of II point

row = row+1;

%row 3 P3(0) = W3

A(row,17:24) = polyT(8,0,0);                    %% coefficients of third polynomial --> from third to fourth point

b(1,row) = points(1,3);                         %% x coordinate of III point

row = row+1;

%row 4 P4(0) = W4

A(row,25:32) = polyT(8,0,0);                    %% coefficients of fourth polynomial --> from fourth to fifth point

b(1,row) = points(1,4);                         %% x coordinate of IV point

row = row+1;

%row 5 P1(T) = W2

A(row,1:8) = polyT(8,0,1);

b(1,row) = points(1,2);

row = row+1;

%row 6 P2(T) = W3

A(row,9:16) = polyT(8,0,1);

b(1,row) = points(1,3);

row = row+1;

%row 7 P3(T) = W4

A(row,17:24) = polyT(8,0,1);

b(1,row) = points(1,4);

row = row+1;

%row8 P4(T) = W5

A(row,25:32) = polyT(8,0,1);

b(1,row) = points(1,5);

row = row+1;

%row 9 P1_dot(0) = 0

A(row, 1:8) = polyT(8,1,0);

row = row+1;

%row 10 P1_ddot(0) = 0

A(row,1:8) = polyT(8,2,0);

row = row+1;

%row 11 P1_dddot(0) = 0

A(row,1:8) = polyT(8,3,0);

row = row+1;

%row 12 P4_dot(T) = 0

A(row,25:32) = polyT(8,1,1);

row = row+1;

%row 13 P4_ddot(T) = 0

A(row,25:32) = polyT(8,2,1);

row = row+1;

%row 14 P4_dddot(T) = 0

A(row,25:32) = polyT(8,3,1);

row = row+1;

%row 15 P1_dot(T) - P2_dot(0) = 0

A(row,1:16) = [polyT(8,1,1), -polyT(8,1,0)];

row = row+1;

%row 16 P2_dot(T) - P3_dot(0) = 0

A(row,9:24) = [polyT(8,1,1), - polyT(8,1,0)];

row = row +1;

%row 17 P3_dot(T) - P4_dot(0) = 0

A(row,17:32) = [polyT(8,1,1), - polyT(8,1,0)];

row = row+1;

%row 18 P1_ddot(T) - P2_ddot(0) = 0

A(row,1:16) = [polyT(8,2,1), - polyT(8,2,0)];

row = row+1;

%row 19 P2_ddot(T) - P3_ddot(0) = 0

A(row,9:24) = [polyT(8,2,1), - polyT(8,2,0)];

row = row +1;

%row 20 P3_ddot(T) - P4_ddot(0) = 0

A(row,17:32) = [polyT(8,2,1), - polyT(8,2,0)];

row = row+1;

%row 21 P1_dot3(T) - P2_dot3(0) = 0

A(row,1:16) = [polyT(8,3,1), - polyT(8,3,0)];

row = row+1;

%row 22 P2_dot3(T) - P3_dot3(0) = 0

A(row,9:24) = [polyT(8,3,1), - polyT(8,3,0)];

row = row +1;

%row 23 P3_dot3(T) - P4_dot3(0) = 0

A(row,17:32) = [polyT(8,3,1), - polyT(8,3,0)];

row = row+1;

%row 24 P1_dot4(T) - P2_dot4(0) = 0

A(row,1:16) = [polyT(8,4,1), - polyT(8,4,0)];

row = row+1;

%row 25 P2_dot4(T) - P3_dot4(0) = 0

A(row,9:24) = [polyT(8,4,1), - polyT(8,4,0)];

row = row +1;

%row 26 P3_dot4(T) - P4_dot3(0) = 0

A(row,17:32) = [polyT(8,4,1), - polyT(8,4,0)];

row = row+1;

%row 27 P1_dot5(T) - P2_dot5(0) = 0

A(row,1:16) = [polyT(8,5,1), - polyT(8,5,0)];

row = row+1;

%row 28 P2_dot5(T) - P3_dot5(0) = 0

A(row,9:24) = [polyT(8,5,1), - polyT(8,5,0)];

row = row +1;

%row 29 P3_dot5(T) - P4_dot5(0) = 0

A(row,17:32) = [polyT(8,5,1), - polyT(8,5,0)];

row = row+1;

%row 30 P1_dot6(T) - P2_dot6(0) = 0

A(row,1:16) = [polyT(8,6,1), - polyT(8,6,0)];

row = row+1;

%row 31 P2_dot6(T) - P3_dot6(0) = 0

A(row,9:24) = [polyT(8,6,1), - polyT(8,6,0)];

row = row +1;

%row 32 P3_dot6(T) - P4_dot6(0) = 0

A(row,17:32) = [polyT(8,6,1), - polyT(8,6,0)];

%deter = det(A);

A_inv = A^(-1);

coff = A_inv*b';