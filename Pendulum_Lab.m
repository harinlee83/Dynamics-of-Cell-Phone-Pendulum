%% Analysis Part 2

clear
clc
close all

angles = ["5","15","25","45","60"]; % angles in degrees
lengths = ["Long", "Short"]; % L2 length (Long or Short)

% Loop through all combinations of angles and lengths, plot, and save them
% into "./figures"
for i = 1:length(angles)
    for j = 1:length(lengths)
        plotter(angles(i),lengths(j))
        saveas(gcf, "./figures/" + angles(i) + lengths(j) + ".png")
    end
end

%% Analysis Part 3

clear
clc
close all

angles = ["5","15","25","45","60"]; % angles in degrees
theoreticalSmallPeriods = []; % theoretical periods using small angle approx.
theoreticalPeriods = [];
experimentalPeriods = [];

for i = 1:length(angles)
    [theoreticalSmallPeriods(i),experimentalPeriods(i)] = smallAnglePeriod(angles(i));
    [theoreticalPeriods(i),experimentalPeriods(i)] = period(angles(i));
    numAngles(i) = str2num(angles(i));
end

% Figure Settings
fontsize = 20;
LineWidth = 3;
MarkerSize = 40;

% Plot the theoretical periods using small angle approximation
figure
plot(numAngles,experimentalPeriods,'.',"MarkerSize", MarkerSize); hold on;
plot(numAngles,theoreticalSmallPeriods,'.',"MarkerSize", MarkerSize); hold on;

grid ON
ylabel("Period (seconds)",'FontSize', fontsize);
xlabel("Theta (degrees)",'FontSize', fontsize);
xticks([5 15 25 45 60])
xticklabels({'5','15','25','45','60'})
title({"Theoretical and Experimental Periods for L2 = .258 cm","using small angle approximation"});
set(gca,'fontweight','bold', 'FontSize', fontsize)
set(gcf,'position',[161,205,1168,532]);
legend('Experimental Period','Theoretical Period','location','northwest')
saveas(gcf, "./figures/periodsWithSmallAngleApprox.png")

% Plot the theoretical periods using series expression
figure
plot(numAngles,experimentalPeriods,'.',"MarkerSize", MarkerSize); hold on;
plot(numAngles,theoreticalPeriods,'.',"MarkerSize", MarkerSize); hold on;

grid ON
ylabel("Period (seconds)",'FontSize', fontsize);
xlabel("Theta (degrees)",'FontSize', fontsize);
xticks([5 15 25 45 60])
xticklabels({'5','15','25','45','60'})
title("Theoretical and Experimental Periods for L2 = .258 cm");
set(gca,'fontweight','bold', 'FontSize', fontsize)
set(gcf,'position',[161,205,1168,532]);
legend('Experimental Period','Theoretical Period','location','northwest')
saveas(gcf, "./figures/periodsWithoutSmallAngleApprox.png")