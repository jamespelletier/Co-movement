function CF_spread_fit(tdata, wdata)

% Fits increase in width of Gaussian cloud of uncaged fluorescein for Diffusion
% coefficient D (param 1) and release time tau (param 2)

% tdata. Time
% wdata. Width

% Convert from pixels to microns
px2um = 0.3225;
wdata = wdata*px2um;

% Lower bound
% Diffusion coefficient: 0 µm2/s (stationary)
% Time: Timestamp of frame 0 (last frame before uncaging)
lb = [0, 0];

% Upper bound
% Diffusion coefficient: 10000 µm2/s (faster than D_water ~ 2300 µm2/s
% Time: Timestamp of frame 1 (first frame after uncaging)
ub = [10000, tdata(1)];

% Guess
% Diffusion coefficient: 425 µm2/s (D_fluorescein ~ 425 µm2/s)
% Time: Halfway between last frame before uncaging, and first frame after uncaging
g = [425, tdata(1)/2];

% Fit
[w, ~, ~, ~] = lsqcurvefit(@CF_spread, g, tdata, wdata, lb, ub);

% Output fit diffusion coefficient and release time
disp(['Viscosity: ', num2str(425*(273+18)/(273+25)/w(1)), ' times water'])
disp(['Release time: ', num2str(w(2))])

% Plot
plot(tdata-w(2), wdata, 'r.')
hold on
plot(tdata-w(2), CF_spread(w, tdata), 'k')
plot(tdata-w(2), CF_spread([425*(273+18)/(273+25), w(2)], tdata), 'b')
plot(tdata-w(2), CF_spread([425/20*(273+18)/(273+25), w(2)], tdata), 'b')
hold off

xlim = get(gca, 'xlim');
set(gca, 'xlim', [0 xlim(2)])
ylim = get(gca, 'ylim');
set(gca, 'ylim', [0 ylim(2)])
xlabel('Time (s)')
ylabel('Width of fluorescein cloud (µm)')

end