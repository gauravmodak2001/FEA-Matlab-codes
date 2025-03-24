function[]= xy_coordinate_plot(elements_structure)
%% Plotting x and y vs the Nodes %%
N=elements_structure.shapeFunctions;
x=elements_structure.x;
y=elements_structure.y;
% Check for the dimensions of matrix M
[n,m,p]= size(N); % condition for contour plot

% Divide the number of plots equally for subplots
l = p/2; % equally dividing the number of plots to load to sub plots

% Loop through the plots with a step size of 2 to avoid zero values
    for plotId = 1 :2: p %looping to create subplots %with step size 2 to avoid the zero values 
      
         % Create subplot
         subplot(2,l, plotId) ; % subplot creation
    
         % Access the 3rd dimension of matrix to plot
         z = N(:,:,plotId);

         % Plotting commands and options    
         contourf(x,y,z);
         xlabel(['x']);
         ylabel(['y']);
         colorbar;
            title(strcat('N', num2str((plotId))));
         axis auto;
    end
end