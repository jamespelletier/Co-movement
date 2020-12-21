function overlay_pairs_nozone(beads, pairs, t)

minT = 1;
maxT = 10;

Npairs = size(pairs, 1);

hold on
for i=1:Npairs
    idx1 = pairs(i, 1);
    idx2 = pairs(i, 2);
    
    % Show only pairs between beads in the image for the entire movie
    if minT < min(beads(idx1).t) || maxT > max(beads(idx1).t)
        continue
    end
    if minT < min(beads(idx2).t) || maxT > max(beads(idx2).t)
        continue
    end
    
    X1 = beads(idx1).x(t);
    Y1 = beads(idx1).y(t);
    X2 = beads(idx2).x(t);
    Y2 = beads(idx2).y(t);
    
    if pairs(i, 3) == 0
        plot([X1 X2], [Y1 Y2], 'b-', 'LineWidth', 1)
    elseif pairs(i, 3) == 0.5 || pairs(i, 3) == 1
        %plot([X1 X2], [Y1 Y2], 'r-', 'LineWidth', 1)
    end
end
hold off

end