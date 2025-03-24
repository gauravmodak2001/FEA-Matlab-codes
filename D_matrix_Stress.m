function D_pl_stress = D_matrix_Stress(data)
    % D_matrix_Stress: Calculate D matrix for Plane Stress condition
    E=data.E;
    v=data.v;
    D_pl_stress=(E / (1 - v^2)) * [1, v, 0; v, 1, 0; 0, 0, (1 - v)/2];

end
