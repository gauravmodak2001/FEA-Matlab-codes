function Global_elements_structure=Global_Stifness_Matrix(convert_to_index,elements_structure,data)
connectivityMatrix=data.Connectivity;
nTotalDof=data.nTotalDOF;
nDOFPNODE=data.nDOFPNode;
[numElements,num_elemental_nodes] = size(connectivityMatrix);
K=zeros(nTotalDof,nTotalDof);
F_s=zeros(nTotalDof,1);
Global_elements_structure(1).K = [];
Global_elements_structure(1).F = [];

for i=1:numElements
    K_elements=elements_structure(i).Stiffnessmatrix;
    F_Surface_Force_Elements=elements_structure(i).SurfaceForce;
    for j=1:num_elemental_nodes
        for k=1:nDOFPNODE
             elemental_row=convert_to_index(j,k,nDOFPNODE);
             Local_row_Node=connectivityMatrix(i,j);
             Local_Row=convert_to_index(Local_row_Node,k,nDOFPNODE);
             F_s(Local_Row)=F_s(Local_Row)+F_Surface_Force_Elements(elemental_row);
             for l=1:num_elemental_nodes
                for m=1:nDOFPNODE
                     elemental_col=convert_to_index(l,m,nDOFPNODE);
                     Local_Col_Node=connectivityMatrix(i,l);
                     Local_Col=convert_to_index(Local_Col_Node,m,nDOFPNODE);
                     K(Local_Row,Local_Col)=K(Local_Row,Local_Col)+K_elements(elemental_row,elemental_col);

                end
            end
         end
    end

end  
Global_elements_structure.K=K;
Global_elements_structure.F=F_s;