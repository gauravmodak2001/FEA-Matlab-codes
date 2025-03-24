function[K,F]=assemblyBC(data,Global_elements_structure)
k_max=max(Global_elements_structure.K,[],'all');
C=k_max*10^4;
K=Global_elements_structure.K;
F=Global_elements_structure.F;

for i=1: length(data.BCnodes)
    
        nDOF=data.BCDof(i);
        nNode=data.BCnodes(i);
        index=convert_to_index(nNode,nDOF,data.nDOFPNode);

        %Apply Boundary conditions
        F(index)=F(index)+C*data.BC(i);
        K(index,index)=K(index,index)+C;
end
