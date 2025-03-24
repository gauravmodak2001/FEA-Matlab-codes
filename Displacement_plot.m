function [] = Displacement_plot(Displacementandstraincalc, data)
    %% Plotting Displacement vs Xi and Eta %%

    % Loop through the elements
    for i = 1:data.numElements
        % Access displacement data for the i-th element
        u = Displacementandstraincalc(i).U;
        x_values = Displacementandstraincalc(i).x;
        y_values = Displacementandstraincalc(i).y;

        % Check the size of displacement data
        [~, ~, p] = size(u);

        % Loop through the displacement components
        for plotId = 1:p
            % Create subplot
            subplot(1, p, plotId);

            % Extract values for plotting
            w = u(:, :, plotId);

            % Plot the data
            contourf(x_values, y_values, w);

            % Adjust mesh grid for smoother appearance
            shading interp;
            colormap jet;

            % Add labels and title
            xlabel('x');
            ylabel('y');
            zlabel(['u', num2str(plotId)]);
            title(['Displacement Component ', num2str(plotId)]);

            % Hold on for subsequent plots
            hold on;
        end 
    end
    
    % Set global title
    sgtitle('Displacements');
end
