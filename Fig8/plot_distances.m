function plot_distances(beads_Hook2, beads_IgG)

% d20191109

% Control
cX = 1052;
cY = 974;

% CytoD
%cX = 963.6;
%cY = 1051.9;

% - - - - -

% Control
%cX = 286;
%cY = 289;

% CytoD
%cX = 586;
%cY = 586;

Nbeads_Hook2 = length(beads_Hook2);
Nbeads_IgG = length(beads_IgG);

delT = 5/60;
px2um = 0.32;

hold on
for i=1:Nbeads_Hook2
    T = (1:size(beads_Hook2(i).traj, 1))'*delT;
    traj = beads_Hook2(i).traj;
    dst = sqrt((traj(:, 1)- cX).^2 + (traj(:, 2)- cY).^2)*px2um;
    beads_Hook2(i).dst = dst;
    plot(T, dst, 'r.-')
end

for i=1:Nbeads_IgG
    T = (1:size(beads_IgG(i).traj, 1))'*delT;
    traj = beads_IgG(i).traj;
    dst = sqrt((traj(:, 1)- cX).^2 + (traj(:, 2)- cY).^2)*px2um;
    beads_IgG(i).dst = dst;
    plot(T, dst, 'b.-')
end
hold off

xlabel('Time (min)')
ylabel('Distance from centrosome (µm)')

end