function J = Jacobian_Calculation(Diff_Shape_functions, Xi_Coor, X,s)
    % Calculate the derivative of shape functions
    dN_cap = Diff_Shape_functions(Xi_Coor, s);

    % Compute the Jacobian matrix
    J = dN_cap * X;

    % Reshape the Jacobian matrix to a square matrix
    matrixSize = sqrt(size(J, 1));
    J = reshape(J, [matrixSize, matrixSize]);
end