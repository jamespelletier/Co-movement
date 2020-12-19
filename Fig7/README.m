%{

Functions were used in this order:

To load and prepare image sequence for kymograph analysis:
load_stack . . . . . . . . . . . . loads a sequence of images into a cell array
track_bead_manual  . . . . . . . . tracks MTOC over sequence by user clicks
translate_stack  . . . . . . . . . dark current subtraction, flat field correction, and translates each image so MTOC stationary
crp_stack  . . . . . . . . . . . . crops images to a quadrant of the aster with MTOC in corner
save_stack . . . . . . . . . . . . saves cell array as sequence of images

To generate kymographs and flux maps from image sequence:
analyze_angularRange . . . . . . . MAIN FUNCTION to generate kymographs and flux maps from sequence of cropped images. Calls these functions:
radial_kymograph_angularRange  . . generates kymograph from the image sequence, the average intensity in concentric shells away from the MTOC. Calls:
radial_histogram_angularRange  . . generates histogram for single image, the average intensity in concentric shells away from the MTOC
normalize_kymo_sum . . . . . . . . normalizes each kymograph row to total intensity, accounting for the increase in shell area with radius
kymo2flux  . . . . . . . . . . . . generates flux map (total flux between concentric shells, scales with radius) from normalized kymograph
kymo2vel . . . . . . . . . . . . . generates velocity map (average speed, does not scale with radius) from normalized kymograph

To plot velocity maps:
plot_kymo_color  . . . . . . . . . plots kymograph as profiles colored by time
plot_kymo_redblue  . . . . . . . . plots kymograph as velocity map
redblue  . . . . . . . . . . . . . red/blue colormap for velocity map

%}