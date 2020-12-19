function plot_kymo_redblue(vel)

figure
colormap(redblue(100))

vel_range = 15;
imagesc(flipud(rot90(vel)), [-vel_range vel_range]) % Flux

set(gca, 'YDir', 'normal')

Xmax_bins = size(vel, 1);
delX_min = 2;
dT = 0.33;
Xtks = 0:delX_min/dT:Xmax_bins;
for i=1:length(Xtks)
    Xtks_label{i} = num2str(Xtks(i)*dT); %#ok<AGROW>
end
xlim([0 Xmax_bins+1])
xticks(Xtks)
xticklabels(Xtks_label)

Ymax_bins = size(vel, 2);
delY_um = 100;
dR = 31.25;
px2um = 0.32;
Ytks = 0:delY_um/dR/px2um:Ymax_bins;
for i=1:length(Ytks)
    Ytks_label{i} = num2str(Ytks(i)*dR*px2um); %#ok<AGROW>
end
ylim([0 Ymax_bins+1])
yticks(Ytks)
yticklabels(Ytks_label)

set(gca, 'FontSize', 12)

xlabel('Time (min)')
ylabel('Distance from centrosome (µm)')

%set(gca, 'visible', 'off')

cbh = colorbar;
set(cbh, 'YTick', [-vel_range 0 vel_range])
cbh.Label.String = 'Average speed (µm/min)';
cbh.FontSize = 12;

set(gcf, 'Position', [327.4 419 601.6 342.8])

end