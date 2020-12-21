function drift = drift_fit(traj_bead, traj_cloud)

% This function finds the constant drift velocity that minimizes the net square difference between two trajectories

% Trajectory 1: Bead trajectory
Xbead = traj_bead(:, 1);
Ybead = traj_bead(:, 2);

% Trajectory 2: Cloud trajectory
Xcloud = traj_cloud(:, 1);
Ycloud = traj_cloud(:, 2);

Nt = length(Xbead);

% Find [driftX, driftY] to minimize net square difference between bead and cloud
fun = @(x)sum((Xcloud + (0:Nt-1)'*x(1) - Xbead).^2 + (Ycloud + (0:Nt-1)'*x(2) - Ybead).^2);
% Start with 0 drift
drift = fminsearch(fun, [0, 0]);

driftX = drift(1);
driftY = drift(2);
Xcloud_drifted = traj_cloud(:, 1) + (0:Nt-1)'*driftX;
Ycloud_drifted = traj_cloud(:, 2) + (0:Nt-1)'*driftY;

% Plot
%{
hold on
for i=1:Nt
    plot([Xcloud(i) Xbead(i)], [Ycloud(i) Ybead(i)], 'b-')
    plot([Xcloud_drifted(i) Xbead(i)], [Ycloud_drifted(i) Ybead(i)], 'r-')
end
plot(traj_bead(:, 1), traj_bead(:, 2), 'k.-')
plot(traj_cloud(:, 1), traj_cloud(:, 2), 'b.-')
plot(Xcloud_drifted, Ycloud_drifted, 'r.-')

hold off
%}

cmap = parula(round(34*1.2));

hold on
for i=1:Nt
    plot(traj_bead(i, 1), traj_bead(i, 2), '.', 'Color', cmap(i, :), 'MarkerSize', 13)
    plot(traj_cloud(i, 1), traj_cloud(i, 2), '+', 'Color', cmap(i, :), 'MarkerSize', 7)
    plot(Xcloud_drifted(i), Ycloud_drifted(i), 's', 'Color', cmap(i, :), 'MarkerSize', 7)
end

sX = 500;
sY = 650;
quiver(sX, sY, driftX, driftY, 0, 'k', 'MaxHeadSize', 100)

hold off

xlim([450 850])
ylim([300 700])
axis square

end