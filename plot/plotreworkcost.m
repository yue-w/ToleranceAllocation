
METRIC = 1;


reworkcostratio = 0.1:0.05:1;

switch METRIC
    case 0 %Befefit
        plotBenefit(reworkcostratio);
    case 1 %Average Cost
        plotCost(reworkcostratio);
end


function plotBenefit(reworkcostratio)
profitA0 = [3.03E+05 3.01E+05 3.00E+05 2.98E+05 2.97E+05 2.96E+05 2.95E+05...
    2.94E+05 2.94E+05 2.93E+05 2.92E+05 2.92E+05 2.91E+05 2.90E+05 2.90E+05 2.89E+05 2.89E+05 2.89E+05 2.88E+05];
figure
nameFig = 'reworkcost';
plot(reworkcostratio,profitA0,'b-o')


hold on
profitA20=[2.60E+05 2.57E+05 2.55E+05 2.53E+05 2.51E+05 2.50E+05 2.49E+05...
    2.47E+05 2.47E+05 2.46E+05 2.45E+05 2.44E+05 2.43E+05 2.43E+05 2.42E+05 2.42E+05 2.41E+05 2.41E+05 2.40E+05];
plot(reworkcostratio,profitA20,'r-o')

hold on
profitA100=[1.55E+05 1.49E+05 1.44E+05 1.40E+05 1.37E+05 1.33E+05 1.31E+05...
    1.29E+05 1.27E+05 1.25E+05 1.23E+05 1.21E+05 1.20E+05 1.18E+05 1.18E+05 1.17E+05 1.15E+05 1.15E+05 1.14E+05];
plot(reworkcostratio,profitA100,'g-o')


%Plot the lines
hline=refline(0,2.86E+05);% adds a reference line with slope m and intercept b to the current axes.
hline.Color = 'b';
hline.LineStyle = '--';

hline=refline(0,2.39E+05);% adds a reference line with slope m and intercept b to the current axes.
hline.Color = 'r';
hline.LineStyle = '--';

hline=refline(0,1.09E+05);% adds a reference line with slope m and intercept b to the current axes.
hline.Color = 'g';
hline.LineStyle = '--';

legends = {'A=0   (rework)','A=20  (rework)','A=100 (rework)','A=0   (no rework)','A=20  (no rework)','A=100 (no rework)'};
xLim=[0.1,1];
xTick = 0.1:0.1:1;
yLim=[0.8E+05 3.3E+05];
yTick= min(yLim):(max(yLim)-min(yLim))/10:max(yLim);
% legendX = 5.9;
% legendY = 6.8;
%legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
legendPosition =[3.09591672698842 3.33895834870947 6.66749987935647 1.1641666359144];
xLabel='\beta';
yLabel='Profit (USD)';
setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legends, legendPosition );
end

function plotCost(reworkcostratio)
profitA0 = [18.836 18.968 19.071 19.162 19.236 19.32 19.37 19.423...
    19.489 19.51 19.575 19.593 19.629 19.667 19.686 19.714 19.724 19.764 19.776];
figure
nameFig = 'reworkcost';
plot(reworkcostratio,profitA0,'b-o')


hold on
profitA20=[22.508 22.884 23.198 23.417 23.643 23.821 23.99 24.134 24.269...
    24.394 24.484 24.608 24.687 24.782 24.864 24.928 24.988 25.08 25.14];
plot(reworkcostratio,profitA20,'r-o')

hold on
profitA100=[34.664 35.255 35.729 36.132 36.472 36.753 36.987 37.293 37.417...
    37.649 37.826 37.975 38.113 38.229 38.312 38.432	38.52 38.66 38.674];
plot(reworkcostratio,profitA100,'g-o')


%Plot the lines
lineWidth = 1;
x = [0 ,1];
y0 = [19.87 ,19.87];
pl = line(x,y0,'Color','b','LineStyle','--','LineWidth',lineWidth);

y20 = [25.32,25.32];
pl = line(x,y20,'Color','r','LineStyle','--','LineWidth',lineWidth);

y100 = [39.21,39.21];
pl = line(x,y100,'Color','g','LineStyle','--','LineWidth',lineWidth);

% hline=refline(0,19.87);% adds a reference line with slope m and intercept b to the current axes.
% hline.Color = 'b';
% hline.LineStyle = '--';

% hline=refline(0,25.32);% adds a reference line with slope m and intercept b to the current axes.
% hline.Color = 'r';
% hline.LineStyle = '--';

% hline=refline(0,39.21);% adds a reference line with slope m and intercept b to the current axes.
% hline.Color = 'g';
% hline.LineStyle = '--';

legends = {'A=0   (rework)','A=20  (rework)','A=100 (rework)','A=0   (no rework)','A=20  (no rework)','A=100 (no rework)'};
xLim=[0.1,1];
xTick = 0.1:0.1:1;
yLim=[16 41];
yTick= min(yLim):(max(yLim)-min(yLim))/10:max(yLim);
% legendX = 5.9;
% legendY = 6.8;
%legendPosition = [legendX legendY 0.001 0.01];% Define the position and dimensions of the legend
legendPosition =[3.14883339365509 4.68833334870947 6.66749987935647 1.1641666359144];
xLabel='\beta';
yLabel='{\it P}({\itK}) (USD)';
setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legends, legendPosition );
end

function setFigProperty(nameFig,xLabel,yLabel,xLim,xTick,yLim, yTick,legends, legendPosition )
%This function is used to adjust the figure
    axis_font_size =7;%For CIRP the font is 8. The original font size is 10 
    legend_font_size=7;
    figure_linewidth = 1;
    legend_linewidth=0.5;
    %mark_size=15;

    property_legend=legend(legends);
    % icons(1).Position = [0.1 0.1 0.01 ];
    % icons(1).Units='centimeters';
    % icons(2).XData = [0.05 0.01];
    property_legend.FontSize=legend_font_size;
    property_legend.FontName='times new roman';
    property_legend.LineWidth=legend_linewidth;
    property_legend.Units = 'centimeters';
    % property_legend.NumColumns=1;
    property_legend.Position=legendPosition;% Define the position and dimensions of the legend
    property_legend.NumColumns = 2;

    af = gcf;%Current figure
    % af.PaperUnits='centimeters';
    % af.PaperSize=[30 30];   % width by heigth     No efffect on the output
    af.Units = 'centimeters';
    af.Position = [4 4 10.5 8.5]; %Location and size of the drawable area, specified as a vector of the form [left bottom width height]. 
    %This area excludes the figure borders, title bar, menu bar, and tool bar,[left bottom width height]
    %af.OuterPosition = [5 5 9 8];    Define the figure size which is 9*8

    ax = gca;%Current axes or chart
    ax.Units = 'centimeters';
    ax.FontSize = axis_font_size;
    ax.LineWidth = figure_linewidth ;
    ax.FontName = 'times new roman';
    ax.FontWeight = 'normal';
    ax.Position = [1.4 1.2 8.6 6.8]; % Define the distance between the axis and the figure, and the width and heigth of the axis
    ax.XLim = xLim;% Range
    ax.XTick = xTick;% Tick label
    ax.XLabel.String = xLabel;
    ax.XLabel.FontSize = axis_font_size;
    ax.XGrid='on';
    % ax.XMinorGrid='on';
    % ax.XAxis.MinorTick = 'on';
    % %ax.XAxis.MinorTickValues = 1:0.5:10;
    ax.TickLength = [0.01 0.01];% Ticklength
    ax.YLim = yLim;
    ax.YTick = yTick;
    %ax.YLabel.String = yLabel;
    ax.YLabel.FontSize = axis_font_size;
    ax.YGrid='on';% grid
    % ax.YMinorGrid='on';%minor grid
    ax.GridLineStyle = '-';
    % ax.MinorGridLineStyle = '--'
    ax.GridColor=[100 100 100]/255;
    ax.GridAlpha = 0.2;
    ax.YLabel.String = yLabel;
    ax.YLabel.FontSize = axis_font_size;
    box on;

    print('-dtiff','-r300',nameFig);
end