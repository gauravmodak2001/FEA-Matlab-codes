function elements_structure = create_elements_structure(data)

connectivityMatrix=data.Connectivity;
allNodalLocations=data.GlobalNodes;
D=data.D;
nDOFPNode=data.nDOFPNode;
n=10;
numElements = size(connectivityMatrix, 1);
numNodes=length(connectivityMatrix);
x(1:n+1,1:n+1) = 0;
y(1:n+1,1:n+1) = 0;
elements_structure(numElements).shapeFunctions = [];
elements_structure(numElements).DiffShapefunctions = [];
elements_structure(numElements).Stiffnessmatrix = [];
elements_structure(numElements).SurfaceForce = [];
elements_structure(numElements).x = [];
elements_structure(numElements).y = [];
surface=1;
%Force_Nodes=[1];
 %Force_Nodes=[0;0;0;0;0;0;0;1;1;1;1;1;1;1];
% Loop through each element in the connectivity matrix
for i = 1:numElements
        % Decide the number of nodes for the current element
        nNodes = size(connectivityMatrix, 2);
        nodeIndices = connectivityMatrix(i, :);
        X = allNodalLocations(nodeIndices, :);
        X = reshape(X.', [], 1);
       
        Xi_coor = [0.93246, 0.661209, 0.23861, -0.23861, -0.661209, -0.93246];
        Weights=[0.1713244, 0.36076, 0.467913, 0.467913, 0.36076, 0.1713244];
        % Xi_coor = [-0.5077,0.5077];
        % Weights = [1,1];
        Gauss_in_Eta=6;
        Gauss_in_Xi=6;

        Stiffnessmatrix=Calculate_K_matrix(nNodes,X, D, Gauss_in_Xi, Gauss_in_Eta, Xi_coor, Weights,data);

        % if(Force_Nodes(i,1)==1)
        %         SurfaceForce=Surface_Traction_Calc(Gauss_in_Eta,nNodes,Xi_coor,X,Weights,surface,data);
        % else
                SurfaceForce=zeros(nDOFPNode*numNodes,1);
        % end

        
         for j=1:Gauss_in_Eta
             for k=1:Gauss_in_Xi
                 shapeFunctions = Shape_function([Xi_coor(j),Xi_coor(k)], nNodes);
                 DiffShapefunctions=Diff_Shape_functions([Xi_coor(j),Xi_coor(k)], nNodes);
                 temp_C = calculate_coordinates(@Shape_function, [Xi_coor(j),Xi_coor(k)], X,nNodes);
                        x(j,k) = temp_C(1,1);
                        y(j,k) = temp_C(2,1); 
             end
         end

            elements_structure(i).SurfaceForce=SurfaceForce;
            elements_structure(i).shapeFunctions = shapeFunctions;
            elements_structure(i).DiffShapefunctions = DiffShapefunctions;
            elements_structure(i).Stiffnessmatrix=Stiffnessmatrix;
            elements_structure(i).x = x;
            elements_structure(i).y=y;

end