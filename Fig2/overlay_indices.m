function overlay_indices(beads, t)

N = length(beads);

hold on

for i=1:N
    % Exclude beads not present at time t
    if t < min(beads(i).t) || t > max(beads(i).t)
        continue
    end
    % For each bead, find the relative time index corresponding to the absolute time index
    t_idx = find(beads(i).t == t);
    X = beads(i).x(t_idx);
    Y = beads(i).y(t_idx);
    
    % Overlay bead index on image
    text(X, Y, num2str(i), 'Color', 'g')
end

hold off

%hgexport(gcf, 'im.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

end