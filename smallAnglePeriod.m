% This function returns the theoretical period (small angle approx) and the
% experimental period

function [TheoPeriod,ExpPeriod] = smallAnglePeriod(angle)
    
    length = "Long"; % Analysis only for longer pendulum
    l2 = .258; % length in meters
    omega = 6.10418; % in rad/sec
    
    % Find theoretical period in seconds using small angle approximation
    TheoPeriod = (2*pi/omega);

    file1 = append("./csv files/l2", length, "Theta",angle,".csv");

    % Arbitrary start and end indicies for acceleration data
    startIndex = 1000;
    endIndex = 1400;

    rawdata = readtable(file1,'VariableNamingRule','preserve');
    time = table2array(rawdata(startIndex:endIndex,1));
    ax = table2array(rawdata(startIndex:endIndex,2));
    
    % Calculate experimental period by finding largest period in frame
    % using findpeaks
    [pks,locs] = findpeaks(ax,time);
    ExpPeriod = max(diff(locs));
end