function max_speed(beads, pairs)

% Number of edges
N = size(pairs, 1);

% Initialize vector to exclude edges when both beads do not remain in the
% image over the duration of the movie
exclude = zeros(N, 1);

% Initialize matrix to store edge lengths, i.e., distance between nearest
% neighbors defined by the Delaunay triangulation, over the movie
distance = zeros(10, N);

% Spatial scale (microns per pixel)
px2um = 0.36;

% Loop over edges
for i=1:N
    
    idx1 = pairs(i, 1);
    idx2 = pairs(i, 2);
    
    % Only plot pairs that remain in the field over the entire image stack
    if min(beads(idx1).t) > 1 || max(beads(idx1).t) < 10
        exclude(i) = 1;
        continue
    end
    if min(beads(idx2).t) > 1 || max(beads(idx2).t) < 10
        exclude(i) = 1;
        continue
    end
    
    % Store XY coordinates of beads and calculate distance between them
    for t=1:10
        X1 = beads(idx1).x(t);
        Y1 = beads(idx1).y(t);
        X2 = beads(idx2).x(t);
        Y2 = beads(idx2).y(t);
        distance(t, i) = sqrt((X2 - X1)^2 + (Y2 - Y1)^2)*px2um;
    end
end

% Exclude pairs according to criterion above
distance(:, exclude == 1) = [];

% Time step (min)
delT = 196.6/60;
% T = delT*(1:10);

% Change in edge length between subsequent frames
displacement = distance(2:end, :) - distance(1:end-1, :);

% Divide by two so speed per bead. Speed now in µm/min
speed = displacement/delT/2;

% Third column of the pairs structure says whether CPC-positive zone or no
% zone between the pair of beads
colorkey = pairs(:, 3);
colorkey(exclude == 1) = [];

% Bead pairs remaining in the analysis
N = length(colorkey);

maxspeed_zone = [];
maxspeed_nozone = [];

% Loop over bead pairs and calculate maximum speed of separation. Positive
% speeds are when beads moved toward one another, and negative speeds are
% when beads moved away from one another
for i=1:N
    s = speed(:, i);
    c = colorkey(i);
    
    val = max(abs(s));
    
    % MTOCs move away from one another
    if distance(end, i) > distance(1, i)
        
        % c NOT 0 means zone formed
        if c ~= 0
            maxspeed_zone = [maxspeed_zone; val, distance(1, i)]; %#ok<AGROW>
        else
            maxspeed_nozone = [maxspeed_nozone; val, distance(1, i)]; %#ok<AGROW>
        end
    
    % MTOCs move toward one another
    else
        
        % c NOT 0 means zone formed
        if c ~= 0
            maxspeed_zone = [maxspeed_zone; -val, distance(1, i)]; %#ok<AGROW>
        else
            maxspeed_nozone = [maxspeed_nozone; -val, distance(1, i)]; %#ok<AGROW>
        end
    
    end
    
end

% Plot
%
plot([0 500], [0 0], 'k')
hold on
plot(maxspeed_zone(:, 2), maxspeed_zone(:, 1), 'ro', 'LineWidth', 2)
plot(maxspeed_nozone(:, 2), maxspeed_nozone(:, 1), 'bo', 'LineWidth', 2)

p1 = plot(NaN, NaN, 'bo', 'LineWidth', 2);
p2 = plot(NaN, NaN, 'ro', 'LineWidth', 2);

hold off

legend([p2 p1], {'Zone', 'No zone'})
%}

xlabel('Initial separation distance (µm)')
ylabel('Max separation speed (µm/min)')

xlim([0 500])
ylim([-6 6])

end