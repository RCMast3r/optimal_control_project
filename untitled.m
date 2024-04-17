% Define the original matrix A
A = [1 2 3; 4 5 6; 7 8 9; 10 11 12; 13 14 15];

% Define the matrix B that will replace part of A
B = [100 200 300; 400 500 600];

% Specify the starting row index in A where B should be inserted
startRow = 3;

% Calculate the ending row based on the number of rows in B
endRow = startRow + size(B, 1) - 1;

% Check if the replacement is within the bounds of A and columns match
if endRow > size(A, 1) || size(A, 2) ~= size(B, 2)
    error('Replacement out of bounds or column mismatch between A and B.');
end

% Perform the replacement
A(startRow:endRow, :) = B;

% Display the modified matrix A
disp('Modified matrix A:');
disp(A);

x_0_0 = [0; 0];
x_1_0 = [1; -1];
x_2_0 = [2; 2];
x_3_0 = [13; 3];
x_4_0 = [14; 1.5];
x_5_0 = [17; 2];
x_6_0 = [20; -3];
x_7_0 = [20; 0];

x_inits = [x_0_0; x_1_0; x_2_0; x_3_0; x_4_0; x_5_0; x_6_0; x_7_0];