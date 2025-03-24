function Displacementandstraincalc=Displacementandstraincalc(Global_elements_structure,data)
connectivityMatrix=data.Connectivity;
allNodalLocations=data.updateNodalLocations;
% allNodalLocations=data.GlobalNodes;
x_min = -1;
x_max = 1;
n=10;
Xi = zeros(n + 1, 1);
Eta = zeros(n + 1, 1);
Strain = zeros(n + 1, n + 1, 3);
Stress = zeros(n + 1, n + 1, 3);
x(1:n+1,1:n+1) = 0;
y(1:n+1,1:n+1) = 0;
Displacements = zeros(n + 1, n + 1, 2); % Correct initialization
numElements = size(connectivityMatrix, 1);
numNodes=size(connectivityMatrix,2);
Displacementandstraincalc(numElements).U = [];
Displacementandstraincalc(numElements).Strain = [];
Displacementandstraincalc(numElements).Stress = [];
Displacementandstraincalc(numElements).Xi = [];
Displacementandstraincalc(numElements).Eta = [];
Displacementandstraincalc(numElements).x = [];
Displacementandstraincalc(numElements).y = [];
for i=1:numElements
    % Decide the number of nodes for the current element
        nodeIndices = connectivityMatrix(i, :);
        X = allNodalLocations(nodeIndices, :);
        X = reshape(X.', [], 1);
        Q_indices = (nodeIndices - 1) * 2 + 1; % Starting indices of Q for the current element
        Q = Global_elements_structure.Q([Q_indices; Q_indices + 1]); % Extract Q values for nodes i and i+1
        Q = reshape(Q, [], 1); % Reshape Q to be 16x1 
        for j=1:(n+1)
             Xi(j, 1) = x_min(1) + ((j - 1) * (x_max(1) - x_min(1))) / n;
            for m=1:(n+1)
                Eta(m, 1) = x_min(1) + ((m - 1) * (x_max(1) - x_min(1))) / n;
                    % Calculate B matrix and remaining parts (not included for brevity)
                    B = Calculate_B_matrix(@Diff_Shape_functions, [Xi(j, 1), Eta(m, 1)], X, numNodes);
                        % Calculate stress and strain
                        temp_V = strain_cal(B, Q);
                        % Store strain and stress
                        Strain(j,m,:) = temp_V;
                        Stress(j,m,:) = data.D*temp_V;
                        temp_C = calculate_coordinates(@Shape_function, [Xi(j,1), Eta(m,1)], X,numNodes);
                        x(j,m,:) = temp_C(1,1);
                        y(j,m,:) = temp_C(2,1); 
                        % Extract strain and stress vectors
                        strain_vector = reshape(Strain( j,m, :), [], 1);
                        Stress_vector = reshape(Stress( j,m,:),[],1);
                        temp_U = Disp_function(@Shape_function, [Xi(j,1), Eta(m,1)], Q, numNodes);
                        for o = 1:2
                          Displacements(j, m, o) = temp_U(o,1);
                           Displacementandstraincalc(i).U(j,m,o) = Displacements(j,m,o);
                        end
                     
                        Displacementandstraincalc(i).Strain(j,m,:) = strain_vector;
                        Displacementandstraincalc(i).Stress(j,m,:) = Stress_vector;
                       
            end
        end
        % Store Xi and Eta values
        Displacementandstraincalc(i).Xi = Xi;
        Displacementandstraincalc(i).Eta = Eta;
        Displacementandstraincalc(i).x = x;
        Displacementandstraincalc(i).y = y;
        
end

       