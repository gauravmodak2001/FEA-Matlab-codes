function [I]=Surface_Traction_Calc(gauss_point_Xi,s,Integration_points,X,Weights,surface,data)
I=zeros;
for i=1:gauss_point_Xi
    
    if surface==1
    
       N=Shape_function([1,Integration_points(i)],s);
        J=Jacobian_Calculation(@Diff_Shape_functions,[1,Integration_points(i)],X,s);
        Det_J=sqrt(J(2,1)^2+J(2,2)^2);
        X_vec=calculate_coordinates(@Shape_function,[1,Integration_points(i)],X,s);
        f_s = [data.f(1)+data.f(2) * X_vec(1); data.f(3)*X_vec(2)+data.f(4)*X_vec(2)];
        %f_s = [data.f(1)+(data.f(2) * X_vec(1)); data.f(3)+(data.f(4)*X_vec(2))];
        I=I+N'*f_s*Det_J*Weights(i)*data.thikness;
    elseif surface==2
    
        N=Shape_function([-1,Integration_points(i)],s);
        J=Jacobian_Calculation(@Diff_Shape_functions,[-1,Integration_points(i)],X,s);
        Det_J=sqrt(J(2,1)^2+J(2,2)^2);
        X_vec=calculate_coordinates(@Shape_function,[-1,Integration_points(i)],X,s);
        f_s = [data.f(1)+(data.f(2) * X_vec(1)); data.f(3)+(data.f(4)*X_vec(2))];
        I=I+N'*f_s*Det_J*Weights(i)*data.thikness;
    elseif surface==3
        % 
        N=Shape_function([Integration_points(i),1],s);
        J=Jacobian_Calculation(@Diff_Shape_functions,[Integration_points(i),1],X,s);
        Det_J=sqrt(J(1,1)^2+J(1,2)^2);
        X_vec=calculate_coordinates(@Shape_function,[Integration_points(i),1],X,s);
        f_s = [data.f(1)+data.f(2) * X_vec(1); data.f(3)*X_vec(2)+data.f(4)*X_vec(1)];
        %f_s = [data.f(1)+(data.f(2) * X_vec(1)); data.f(3)+(data.f(4)*X_vec(2))];
        I=I+N'*f_s*Det_J*Weights(i)*data.thikness;

    elseif surface==4

        N=Shape_function([Integration_points(i),-1],s);
        J=Jacobian_Calculation(@Diff_Shape_functions,[Integration_points(i),-1],X,s);
        Det_J=sqrt(J(1,1)^2+J(1,2)^2);
        X_vec=calculate_coordinates(@Shape_function,[Integration_points(i),-1],X,s);
        f_s = [data.f(1)+(data.f(2) * X_vec(1)); data.f(3)+(data.f(4)*X_vec(2))];
        I=I+N'*f_s*Det_J*Weights(i)*data.thikness;
    end

end