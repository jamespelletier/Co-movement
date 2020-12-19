function plot_kymo_color(kymo)

% Number of time points
N_timePoints = size(kymo, 1);

% Bin width (31.25 px makes 10 µm)
um_per_px = 0.32;
dr = 31.25;

% Distance from MTOC
X = (0:size(kymo, 2)-1)*dr*um_per_px;

% Colormap for profiles colored by time
cmap = bone(round(N_timePoints*1.3));

% Plot profiles
hold on
for t=1:N_timePoints
    plot(X, kymo(t, :), 'Color', cmap(t, :), 'LineWidth', 2)
end
hold off
set(gca, 'TickLength', [0 0])

end