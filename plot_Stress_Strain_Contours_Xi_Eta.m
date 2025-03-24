function plot_Stress_Strain_Contours_Xi_Eta(Displacementandstraincalc, data)
    % Plot individual contour plots for stress and strain components
    % Initialize figure
    figure;
    % Plot Stress and Strain for each element
    for j = 1:data.numElements
        Strain = Displacementandstraincalc(j).Strain;
        Stress = Displacementandstraincalc(j).Stress;
        y = Displacementandstraincalc(j).y;
        x = Displacementandstraincalc(j).x;
        nRows = size(Strain, 3);
        % Plot Stress (S12 only)
        subplot(1, nRows, 1);
        hold on; % Enable hold on for subsequent plots
        surf(x, y, Stress(:,:,2),EdgeColor="black"); % Access S12 component only
        % Adjust mesh grid for smoother appearance
        shading interp;
        colormap jet;
        title('Stress - S12');
        xlabel('x');
        ylabel('y');
        zlabel('Stress');
        colorbar

    end
    
end
