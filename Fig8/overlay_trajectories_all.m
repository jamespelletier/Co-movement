function overlay_trajectories_all(im, beads_Hook2)

imshow(im, [])

hold on
N = length(beads_Hook2);
for i=1:N
    plot(beads_Hook2(i).traj(:, 1), beads_Hook2(i).traj(:, 2), 'r.-')
    %text(beads(i).traj(1, 1), beads(i).traj(1, 2), num2str(i), 'Color', 'r')
end

%{
N = length(beads_IgG);
for i=1:N
    plot(beads_IgG(i).traj(:, 1), beads_IgG(i).traj(:, 2), 'c.-')
    %text(beads(i).traj(1, 1), beads(i).traj(1, 2), num2str(i), 'Color', 'r')
end
%}
hold off

end