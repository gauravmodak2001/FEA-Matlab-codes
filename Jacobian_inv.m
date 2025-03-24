function J_inv = Jacobian_inv(Diff_Shape_functions, Xi_coor, X,s)

    J = Jacobian_Calculation(Diff_Shape_functions, Xi_coor, X, s);
    nDimensions = size(J, 1);
    J_Inverse = inv(J);

    % Repeat the inverse Jacobian along the diagonal
    J_inv = repmat({J_Inverse}, 1, nDimensions);
    J_inv = blkdiag(J_inv{:});
end