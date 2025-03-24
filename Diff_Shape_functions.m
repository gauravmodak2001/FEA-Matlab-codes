function dN = Diff_Shape_functions(Xi_Coor, s)

if s == 4
    % 4-node configuration for the position (-1,1)
    xi = Xi_Coor(1, 1);
    eta = Xi_Coor(1, 2);

    % Calculate derivatives wrt Xi and Eta for (N1,N2,N3,N4)
    dN1dxi = eta / 4 - 1 / 4;
    dN1deta = xi / 4 - 1 / 4;

    dN2dxi = 1 / 4 - eta / 4;
    dN2deta = -xi / 4 - 1 / 4;

    dN3dxi = eta / 4 + 1 / 4;
    dN3deta = xi / 4 + 1 / 4;

    dN4dxi = -eta / 4 - 1 / 4;
    dN4deta = 1 / 4 - xi / 4;
    

    % Combine derivatives into dN matrix
    dN = [dN1dxi, 0, dN2dxi, 0, dN3dxi, 0, dN4dxi, 0;...
          dN1deta, 0, dN2deta, 0, dN3deta, 0, dN4deta, 0;...
          0, dN1dxi, 0, dN2dxi, 0, dN3dxi, 0, dN4dxi;...
          0, dN1deta, 0, dN2deta, 0, dN3deta, 0, dN4deta];
      
elseif s == 8
    % 8-node configuration for the position (-1,1)
    Xi = Xi_Coor(1, 1);
    Eta = Xi_Coor(1, 2);

    % Calculate xi derivatives
    dN1dxi = -((Eta + 2 * Xi) * (Eta - 1)) / 4;
    dN1deta = -((2 * Eta + Xi) * (Xi - 1)) / 4;

    dN2dxi = Xi * (Eta - 1);
    dN2deta = ((Xi - 1) * (Xi + 1)) / 2;

    dN3dxi = ((Eta - 2 * Xi) * (Eta - 1)) / 4;
    dN3deta = ((Xi + 1) * (2 * Eta - Xi)) / 4;

    dN4dxi = -((Eta - 1) * (Eta + 1)) / 2;
    dN4deta = -Eta * (Xi + 1);

    dN5dxi = ((Eta + 2 * Xi) * (Eta + 1)) / 4;
    dN5deta = ((2 * Eta + Xi) * (Xi + 1)) / 4;

    dN6dxi = -Xi * (Eta + 1);
    dN6deta = -((Xi - 1) * (Xi + 1)) / 2;

    dN7dxi = -((Eta - 2 * Xi) * (Eta + 1)) / 4;
    dN7deta = -((Xi - 1) * (2 * Eta - Xi)) / 4;

    dN8dxi = ((Eta - 1) * (Eta + 1)) / 2;
    dN8deta = Eta * (Xi - 1);
   
   
    % Combine derivatives into dN matrix
    dN = [dN1dxi, 0, dN2dxi, 0, dN3dxi, 0, dN4dxi, 0, dN5dxi, 0, dN6dxi, 0, dN7dxi, 0, dN8dxi, 0;...
          dN1deta, 0, dN2deta, 0, dN3deta, 0, dN4deta, 0, dN5deta, 0, dN6deta, 0, dN7deta, 0, dN8deta, 0;...
          0, dN1dxi, 0, dN2dxi, 0, dN3dxi, 0, dN4dxi, 0, dN5dxi, 0, dN6dxi, 0, dN7dxi, 0, dN8dxi;...
          0, dN1deta, 0, dN2deta, 0, dN3deta, 0, dN4deta, 0, dN5deta, 0, dN6deta, 0, dN7deta, 0, dN8deta];

else
    error('Invalid input. Please enter either 4 or 8 for the number of nodes.');
end