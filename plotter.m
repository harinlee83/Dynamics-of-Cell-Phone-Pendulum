% This function reads in attributes of a filename and plots it

function plotter(angle,length)
    if length == "Long"
        l2 = .258; % length in meters
        omega = 6.10418; % in rad/sec
    else
        l2 = .15; % length in meters
        omega = 7.67327; % in rad/sec
    end

    file1 = append("./csv files/l2", length, "Theta",angle,".csv");

    startIndex = 1000;
    endIndex = 1400;

    rawdata = readtable(file1,'VariableNamingRule','preserve');
    time = table2array(rawdata(startIndex:endIndex,1));
    ax = table2array(rawdata(startIndex:endIndex,2));
    ay = table2array(rawdata(startIndex:endIndex,3));
    az = table2array(rawdata(startIndex:endIndex,4));

    angleRad = str2num(angle) * (pi/180);

    acx = -l2 * angleRad * (omega^2) * cos(omega*time);
    acy = l2 * (angleRad^2) * (omega^2) * (sin(omega*time).^2);

    % Figure Settings
    fontsize = 20;
    LineWidth = 3;
    MarkerSize = 7;

    figure
    plot(time, ax,'.',"MarkerSize", MarkerSize); hold on;
    plot(time, ay,'.',"MarkerSize", MarkerSize); hold on;
    plot(time, az,'.',"MarkerSize", MarkerSize); hold on;
    plot(time, acx, "LineWidth", LineWidth); hold on;
    plot(time, acy, "LineWidth",LineWidth); hold on;
    grid ON
    ylabel("Acceleration (m/s^{2})",'FontSize', fontsize);
    offset = max(ax)*.7; % This is used to make room for the legend
    xlim([time(1) time(end)])
    ylim([min(ax)-offset max(ax)+offset])
    xlabel("Time (s)",'FontSize', fontsize);
    title("Acceleration in X Y Z for \theta = " + angle + "\circ and L2 = " + l2 + " cm");
    set(gca,'fontweight','bold', 'FontSize', fontsize)
    set(gcf,'position',[161,205,1168,532]);
    legend('Ax Experimental','Ay Experimental','Az Experimental','Ax Theoretical','Ay Theoretical','NumColumns',5,'location','northeast')
end
