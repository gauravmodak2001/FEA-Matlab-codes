function updatedNodeCoordinates = updateNodalLocations(data)
    nodeCoordinates = data.GlobalNodes;
    distorted_nodes = data.Total_corner_nodes-(data.top_corner_node + data.bottom_corner_node);
    h = data.mesh_size;
    type=(data.type_of_mesh);
    updatedNodeCoordinates = nodeCoordinates;
    if type== "distorted"

            for i = data.bottom_corner_node+1:(distorted_nodes+data.bottom_corner_node)
                if mod(i, 2) == 1 % Odd indices
                    updatedNodeCoordinates(i, 2) = nodeCoordinates(i, 2) + data.d * h / 2;
                else % Even indices
                    updatedNodeCoordinates(i, 2) = nodeCoordinates(i, 2) - data.d * h / 2;
                end
            end
    elseif type == "Undistorted"

        updatedNodeCoordinates=data.GlobalNodes;

    end
   
end