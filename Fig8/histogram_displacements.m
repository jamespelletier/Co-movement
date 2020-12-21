function vel = histogram_displacements(beads_Hook2, begin)

% Before running this code, manually create an array "begin" that has the first time index at which beads incorporated into aster and start to move

N = length(beads_Hook2);

dsp_all = [];

% Displacements from when each bead starts to move until the end of the trajectory
for i=1:N
    dst_Hook2 = beads_Hook2(i).dst(begin(i):end);
    dsp_Hook2 = dst_Hook2(2:end)-dst_Hook2(1:end-1);
    dsp_all = [dsp_all; dsp_Hook2]; %#ok<AGROW>
end

% Time step and scale to convert from px/frame to microns/s
delT = 5;
px2um = 0.32;

vel = -dsp_all*px2um/delT;

histogram(vel, -0.1:0.05:1.5, 'FaceColor', 'r')

xlim([-0.1 1.5])
xticks([0 0.5 1 1.5])

xlabel('Velocity (µm/s)')

end