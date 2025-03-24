function [K] = Calculate_K_matrix(nNodes,X, D, gauss_point_Xi, gauss_point_Eta, Integration_points, Weights,data)
    % Initialize I matrix
    I = zeros(size(X, 1));
    K = zeros(size(X,1));
    % Loop through each element in the connectivity matrix
   for i=1:gauss_point_Xi
            for j=1:gauss_point_Eta

                 % Calculate B matrix
                B = Calculate_B_matrix(@Diff_Shape_functions, [Integration_points(i),Integration_points(j)], X,nNodes);
                
                % Calculate Jacobian
                J = Jacobian_Calculation(@Diff_Shape_functions, [Integration_points(i),Integration_points(j)],X,nNodes);
                
                % Calculate determinant of J
                Det_J = det(J);
                
                % Evaluate function
                F=Weights(i)*Weights(j)*B'*D*B*Det_J;
                I = I+F;
                K=I*data.thikness;

            end
    end

end
