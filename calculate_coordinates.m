function [x] = calculate_coordinates(Shape_function,Xi_Coor, X,s)
% calling the shape function %
N = Shape_function(Xi_Coor,s);

% calculating the xy coordinates
x = N * X;
end