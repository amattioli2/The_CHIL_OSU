figure;plot(MESH);                                  % Dbay Figure;
surf(MESH);ax = gca; ax.View = [0 90];
title('Deleware Bay');  cb = colorbar;	cb.Label.String = 'Bathymetry (m)';
xlabel('Latitude'); ylabel('Longitude');
[f,a]	= PublishableFigures(gcf,gca);
% Adjust figure for better aesthetic.
offset	= min(abs(ax.XLim(1)-ax.XLim(2)),abs(ax.YLim(1)-ax.YLim(2)))*.01;
axis([ax.XLim(1)-offset ax.XLim(2)+offset...
    ax.YLim(1)-offset ax.YLim(2)+offset]);
daspect([1 1 1]);                   % Correct data aspect.
set(gcf,'Color',[1 1 1]);           % White background.
box on;                             % Make axis pretty:
Ax.FontSize	= 14;                   % Big axis labels.
Ax.FontWeight	= 'bold';           % Bold ^.
Ax.LineWidth	= 2;                % Big axis lines.
Ax.Units	= 'normalized';
Ax.Position	= [0.05 0.05 0.9 0.9];  % Make axis larger.

figure;plot(MESH);                                  % Dbay-Zoom Figure;
surf(MESH);ax = gca; ax.View = [0 90];
title('Deleware Bay');  cb = colorbar;	cb.Label.String = 'Bathymetry (m)';
xlabel('Latitude'); ylabel('Longitude');
[f,a]	= PublishableFigures(gcf,gca);  
% Adjust figure for better aesthetic.
offset	= min(abs(ax.XLim(1)-ax.XLim(2)),abs(ax.YLim(1)-ax.YLim(2)))*.01;
axis([ax.XLim(1)-offset ax.XLim(2)+offset...
    ax.YLim(1)-offset ax.YLim(2)+offset]);
daspect([1 1 1]);                   % Correct data aspect.
set(gcf,'Color',[1 1 1]);           % White background.
box on;                             % Make axis pretty:
Ax.FontSize	= 14;                   % Big axis labels.
Ax.FontWeight	= 'bold';           % Bold ^.
Ax.LineWidth	= 2;                % Big axis lines.
Ax.Units	= 'normalized';
Ax.Position	= [0.05 0.05 0.9 0.9];  % Make axis larger.

figure;plot(mesh);                                  % WNAT Figure;
surf(mesh);ax = gca; ax.View = [0 90];
title('Western North Atlantic Basin');  cb = colorbar;	cb.Label.String = 'Bathymetry (m)';
xlabel('Latitude'); ylabel('Longitude');
[f,a]	= PublishableFigures(gcf,gca);
% Adjust figure for better aesthetic.
offset	= min(abs(ax.XLim(1)-ax.XLim(2)),abs(ax.YLim(1)-ax.YLim(2)))*.01;
axis([ax.XLim(1)-offset ax.XLim(2)+offset...
    ax.YLim(1)-offset ax.YLim(2)+offset]);
daspect([1 1 1]);                   % Correct data aspect.
set(gcf,'Color',[1 1 1]);           % White background.
box on;                             % Make axis pretty:
Ax.FontSize	= 14;                   % Big axis labels.
Ax.FontWeight	= 'bold';           % Bold ^.
Ax.LineWidth	= 2;                % Big axis lines.
Ax.Units	= 'normalized';
Ax.Position	= [0.01 0.01 0.98 0.98];  % Make axis larger.

figure;plot(MESH);                                  % Dbay-Zoom Figure;
surf(MESH);ax = gca; ax.View = [0 90];
title('Deleware Bay');  cb = colorbar;	cb.Label.String = 'Bathymetry (m)';
xlabel('Latitude'); ylabel('Longitude');
[f,a]	= PublishableFigures(gcf,gca);  
% Adjust figure for better aesthetic.
offset	= min(abs(ax.XLim(1)-ax.XLim(2)),abs(ax.YLim(1)-ax.YLim(2)))*.01;
axis([ax.XLim(1)-offset ax.XLim(2)+offset...
    ax.YLim(1)-offset ax.YLim(2)+offset]);
daspect([1 1 1]);                   % Correct data aspect.
set(gcf,'Color',[1 1 1]);           % White background.
box on;                             % Make axis pretty:
Ax.FontSize	= 14;                   % Big axis labels.
Ax.FontWeight	= 'bold';           % Bold ^.
Ax.LineWidth	= 2;                % Big axis lines.
Ax.Units	= 'normalized';
Ax.Position	= [0.05 0.05 0.9 0.9];  % Make axis larger.

