function [N] = Shape_function(Xi_coor,s)

    % Extract coordinates for clarity
    Xi= Xi_coor(:,1);
    Eta= Xi_coor(:,2);

    % Calculate shape functions based on the number of nodes
    if s == 8
        % Shape functions for 8-node configuration
        N1 = (1-Xi)*(1-Eta)*(1+Xi+Eta)*(-0.25);
        N2 = (1-Xi^2)*(1-Eta)*0.5;
        N3 = (1+Xi)*(1-Eta)*(1-Xi+Eta)*(-0.25);
        N4 = (1+Xi)*(1-Eta^2)*0.5;
        N5 = (1+Xi)*(1+Eta)*(1-Xi-Eta)*(-0.25);
        N6 = (1-Xi^2)*(1+Eta)*0.5;
        N7 = (1-Xi)*(1+Eta)*(1+Xi-Eta)*(-0.25);
        N8 = (1-Xi)*(1-Eta^2)*0.5;

        % Arrange shape functions into a matrix
        N = [N1,0,N2,0,N3,0,N4,0,N5,0,N6,0,N7,0,N8,0; 0,N1,0,N2,0,N3,0,N4,0,N5,0,N6,0,N7,0,N8];

    elseif s == 4
        % Shape functions for 4-node configuration
        N1 = (Xi-1)*(Eta-1)*0.25;
        N2 = (Xi+1)*(Eta-1)*(-0.25);
        N3 = (Xi+1)*(Eta+1)*0.25;
        N4 = (Xi-1)*(Eta+1)*(-0.25);

        % Arrange shape functions into a matrix
        N = [N1,0,N2,0,N3,0,N4,0; 0,N1,0,N2,0,N3,0,N4];

    else
        error('Unsupported number of nodes. Use either 4 or 8 nodes.');
    end
end
