function u = Disp_function(Shape_function, Xi_coor, q, m)
    % Function to calculate displacements using shape functions

    % Calculate shape functions at given Xi coordinates
    N = Shape_function(Xi_coor, m);

    % Calculate displacements using the shape functions and input nodal displacements
    u = N * q;
end