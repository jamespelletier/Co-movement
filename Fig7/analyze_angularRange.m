function [kymo, kymo_n, vel, sz] = analyze_angularRange(stk)

% crp_stack rotates image sequence so the MTOC in the top left corner, which has coordinates (1, 1)
cX = 1;
cY = 1;

% Default theta_range the full image from -90 degrees (vertical down) to 0 degrees (horizontal right)
theta_range = [-90, 0];

% Bin width (31.25 px makes 10 µm) and maximum radius
dr = 31.25;
r_max = 950;

% Generate kymograph
[kymo, sz] = radial_kymograph_angularRange(stk, [cX, cY], theta_range(1), theta_range(2), dr, r_max);

% Normalize kymograph by intensity
kymo_n = normalize_kymo_sum(kymo, sz);

% Calculate flux map from normalized kymograph
%flux = kymo2flux(kymo_n, sz);

% Calculate velocity map from normalized kymograph
vel = kymo2vel(kymo_n, sz, dr);
um_per_px = 0.32;
min_per_fr = 20/60;
vel = vel*um_per_px/min_per_fr;

end