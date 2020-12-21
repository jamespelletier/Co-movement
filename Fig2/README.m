%{

Functions were used in this order:

To load image sequence:
load_stack . . . . . . . . . . . . . . . loads image sequence as cell array

To track MTOCs and show their trajectories:
track_bead_manual  . . . . . . . . . . . tracks MTOCs over sequence by user clicks
    
    MTOC trajectories are stored in an array of structures, each with three components:
        x: X component
        y: Y component
        t: time indices when bead in the image. Some beads may enter or exit the image during the movie
    
    beads already tracked are shown using:
        overlay_bead_trajectory_all  . . overlays all bead trajectories
        overlay_bead_trajectory_red  . . overlays a single trajectory with red

To define neighboring MTOCs using a Delaunay triangulation:
delaunay_pairs . . . . . . . . . . . . . generates an array of bead index pairs, which corresponds to edges in the Delaunay triangulation (DT)
    tri2pairs  . . . . . . . . . . . . . called by delaunay_pairs, converts DT triangles to non-redundant pairs
    
After generating array of bead index pairs, manually add a third column encoding whether a CPC-positive zone formed (1) or not (0):
overlay_indices  . . . . . . . . . . . . overlays bead indices, to help with specification whether zone formed or not

To plot maximum speed of separation with respect to initial separation distance:
max_speed  . . . . . . . . . . . . . . . for each edge, calculates maximum speed of separation vs initial separation distance

To overlay Delaunay edges on images:
overlay_pairs_zone . . . . . . . . . . . overlays red edge if zone formed
overlay_pairs_nozone . . . . . . . . . . overlays blue edge if zone did not form
overlay_pairs_all  . . . . . . . . . . . renders the image stack with all pairs overlayed

%}