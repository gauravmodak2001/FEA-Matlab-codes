function [Integration_Points,Weights] = Gauss_quadrant(num_gauss_points)
    % Function to calculate integration points using Gaussian quadrature
    XiEta_coor = [0, 0, 0, 0, 0, 0; -0.57735, 0.57735, 0, 0, 0, 0; 0, 0.77460, -0.77460, 0, 0, 0; 0.861136, 0.339981, -0.339981,-0.861136, 0, 0; 0.906179, 0.538469, 0, -0.538469, -0.906179, 0; 0.93246, 0.661209, 0.23861, -0.23861, -0.661209, -0.93246];
    W=[2, 0, 0, 0, 0, 0; 1.0, 1.0, 0, 0, 0, 0; 0.88889,0.55556, 0.55556, 0, 0, 0; 0.347854, 0.652145, 0.652145, 0.347854, 0, 0; 0.236926, 0.478628, 0.56888, 0.478628, 0.236926, 0; 0.1713244, 0.36076, 0.467913, 0.467913, 0.36076, 0.1713244];
    % Assume 2D quadrature for simplicity

    if num_gauss_points == 1
        % Single integration point
        Integration_Points = [XiEta_coor(1,1)];
        Weights=[W(1,1)];

    elseif num_gauss_points == 2
            Integration_Points = [ XiEta_coor(2,1), XiEta_coor(2,2)];
            Weights=[W(2,1),W(2,2)];
    elseif num_gauss_points == 3
            Integration_Points = [ XiEta_coor(3,1), XiEta_coor(3,2),XiEta_coor(3,3)];
            Weights=[W(3,1),W(3,2),W(3,3)];
    elseif num_gauss_points==4
            Integration_Points = [ XiEta_coor(4,1), XiEta_coor(4,2),XiEta_coor(4,3),XiEta_coor(4,4)];
            Weights=[W(4,1),W(4,2),W(4,3),W(4,4)];
    elseif num_gauss_points==5
            Integration_Points = [ XiEta_coor(5,1), XiEta_coor(5,2),XiEta_coor(5,3),XiEta_coor(5,4),XiEta_coor(5,5)];
            Weights=[W(5,1),W(5,2),W(5,3),W(5,4),W(5,5)];
    elseif num_gauss_points==6
            Integration_Points = [ XiEta_coor(6,1), XiEta_coor(6,2),XiEta_coor(6,3),XiEta_coor(6,4),XiEta_coor(6,5),XiEta_coor(6,6)];
            Weights=[W(6,1),W(6,2),W(6,3),W(6,4),W(6,5),W(6,6)];
    else    
        error('Unsupported number of Gauss points. Use 1, 2 or 3');
    end
end