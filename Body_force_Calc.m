function [I]=Body_force_Calc( X,s,gauss_point_Xi,Integration_points,Weights,gauss_point_Eta,tz,f0,f1,f2,f3)
I=zeros;
for i=1:gauss_point_Xi
    
    for j=1:gauss_point_Eta
    
        N=Shape_function([Integration_points(i),Integration_points(j)],s);
        J=Jacobian_Calculation(@Diff_Shape_functions,[Integration_points(i),Integration_points(j)],X,s);
        X_vec=calculate_coordinates(@Shape_function,[Integration_points(i),Integration_points(j)],X,s);
        Det_J=det(J);
        f_s = [f0+(f1 * X_vec(1)); f2+(f3*X_vec(2))];
        I=I+N'*f_s*Det_J*Weights(i)*Weights(j)*tz;
    end
end