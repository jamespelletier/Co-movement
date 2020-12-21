%{

Functions were used in this order:

To load image sequence, track MTOC, and translate image sequence to show bead movement relative to MTOC:
load_stack . . . . . . . . . . . . loads image sequence as cell array
track_cnt_threshold  . . . . . . . tracks MTOC based on thresholding image then finding centroid
translate_stack  . . . . . . . . . translates image sequence to show bead movement relative to MTOC

To track beads:
track_bead_threshold . . . . . . . tracks beads based on combination of adaptive thresholding and user clicks

    Outputs each bead as a structure, with absolute X and Y coordinates (traj) and distance relative to MTOC (dst)

The following functions act on all beads combined into an array of structures:

To analyze bead trajectories:
plot_distances . . . . . . . . . . plots distances of beads relative to MTOC
histogram_displacements  . . . . . plots histogram of bead speeds relative to MTOC

To plot bead trajectories:
overlay_trajectories_all . . . . . overlays on image bead trajectories relative to MTOC

%}