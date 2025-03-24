function [B_matrix_result] = Calculate_B_matrix(Diff_Shape_functions,Xi_Coor, X,s)
    % Define matrix A_matrix
    A_matrix = [1 0 0 0; 0 0 0 1; 0 1 1 0];
    % Compute the derivative of shape functions
    Derivative_Nhat_Dxi = Diff_Shape_functions(Xi_Coor, s);

    % Compute the inverse Jacobian matrix
    J_hat_Inverse = Jacobian_inv(@Diff_Shape_functions, Xi_Coor, X,s);

    % Compute B matrix
    %B_matrix_result = A_matrix * J_hat_Inverse * Dn;
    B_matrix_result = A_matrix * J_hat_Inverse * Derivative_Nhat_Dxi;
end
