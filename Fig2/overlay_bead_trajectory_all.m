function overlay_bead_trajectory_all(beads)

N = length(beads);

for i=1:N
    overlay_bead_trajectory_red(beads(i))
end

end