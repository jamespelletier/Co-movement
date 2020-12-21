function vel = kymo_velocity_image(t1, t2, u, v, x, y, stk)

N_timePoints = length(u);

% t1 and t2 are MTOC trajectories
% u and v are horizontal and vertical components of flow field sequence (from PIVlab) as cell arrays
% x and y are X and Y coordinates corresponding to u and v
% stk is image sequence as cell array

% Midpoint between the MTOCs
mid = t1/2 + t2/2;

% Velocity of the midpoint between the MTOCs
mid_vel = mid(2:end, :) - mid(1:end-1, :);

% dst0: Distance from side of image closer to MTOC 1 to midpoint between MTOCs
% dst3: Distance from side of image closer to MTOC 2 to midpoint between MTOCs
% dst12: Distance between MTOCs
dst0 = zeros(N_timePoints, 1);
dst12 = zeros(N_timePoints, 1);
dst3 = zeros(N_timePoints, 1);

im1 = stk{1};
Lx = size(im1, 2);
Ly = size(im1, 1);

% Loop through time points
for i=1:N_timePoints
    
    % X and Y coordinates of MTOCs
    x1 = t1(i, 1);
    y1 = t1(i, 2);
    x2 = t2(i, 1);
    y2 = t2(i, 2);
    
    % X and Y coordinate of midpoint between MTOCs
    xC = (x1+x2)/2;
    yC = (y1+y2)/2;
    
    dst12(i) = sqrt((x1-xC)^2 + (y1-yC)^2);
    
    m = (y2-y1)/(x2-x1);
    
    % Determine X and Y coordinates of points on the image boundary that define a line passing through the MTOCs
    % x0, y0: Point on the image boundary closer to MTOC 1
    % x3, y3: Point on the image boundary closer to MTOC 2
    if m > 0
        if x1 < x2
            x0 = max(1, x1 - (y1-1)/m);
            y0 = max(1, y1 - (x1-1)*m);
            x3 = min(Lx, x1 + (Ly-y1)/m);
            y3 = min(Ly, y1 + (Lx-x1)*m);
        else
            x0 = min(Lx, x1 + (Ly-y1)/m);
            y0 = min(Ly, y1 + (Lx-x1)*m);
            x3 = max(1, x1 - (y1-1)/m);
            y3 = max(1, y1 - (x1-1)*m);
        end
        
    else
        if x1 < x2
            x0 = max(1, x1 + (Ly-y1)/m);
            y0 = min(Ly, y1 - (x1-1)*m);
            x3 = min(Lx, x1 - (y1-1)/m);
            y3 = max(1, y1 + (Lx-x1)*m);
        else
            x0 = min(Lx, x1 - (y1-1)/m);
            y0 = max(1, y1 + (Lx-x1)*m);
            x3 = max(1, x1 + (Ly-y1)/m);
            y3 = min(Ly, y1 - (x1-1)*m);
        end
        
    end
    
    % Find indices in u, v flow fields corresponding to points 0, C, and 3
    % Point 0: Point on image boundary closer to MTOC 1
    % Point 3: Point on image boundary closer to MTOC 2
    % Point C: Midpoint between MTOCs
    % The line through points 0 and 3 passes through the MTOCs
    [~, x0_idx] = min(abs(x(1, :)' - x0));
    [~, x3_idx] = min(abs(x(1, :)' - x3));
    [~, xC_idx] = min(abs(x(1, :)' - xC));
    
    [~, y0_idx] = min(abs(y(:, 1) - y0));
    [~, y3_idx] = min(abs(y(:, 1) - y3));
    [~, yC_idx] = min(abs(y(:, 1) - yC));
    
    im_u = u{i};
    im_v = v{i};
    
    %{
    pause on
    imshow(im, [])
    hold on
    plot([x0 x3], [y0 y3], 'r-*')
    plot(xC, yC, 'g*')
    hold off
    pause
    pause off
    %}
    
    % Store intensity profiles in cell array, as distances between MTOCs and the image boundary will likely change over time
    dst0(i) = round(sqrt((x0-xC)^2 + (y0-yC)^2));
    prof_u0{i} = improfile(im_u, [x0_idx xC_idx], [y0_idx yC_idx], dst0(i)); %#ok<AGROW>
    prof_v0{i} = improfile(im_v, [x0_idx xC_idx], [y0_idx yC_idx], dst0(i)); %#ok<AGROW>
    
    dst3(i) = round(sqrt((x3-xC)^2 + (y3-yC)^2));
    prof_u3{i} = improfile(im_u, [xC_idx x3_idx], [yC_idx y3_idx], dst3(i)); %#ok<AGROW>
    prof_v3{i} = improfile(im_v, [xC_idx x3_idx], [yC_idx y3_idx], dst3(i)); %#ok<AGROW>
end

% Pad profiles with zeros, so all profiles registered to the midpoint between the MTOCs
dst_max0 = max(dst0);
dst_max3 = max(dst3);

dif0 = dst_max0 - dst0;
dif3 = dst_max3 - dst3;

ter_u0 = zeros(dst_max0, N_timePoints);
ter_v0 = zeros(dst_max0, N_timePoints);

ter_u3 = zeros(dst_max3, N_timePoints);
ter_v3 = zeros(dst_max3, N_timePoints);

msk0 = zeros(dst_max0, N_timePoints-1);
msk3 = zeros(dst_max3, N_timePoints-1);

t1_X = dst_max0-dst12;
t2_X = dst_max0+dst12;

for i=1:N_timePoints
    pad0 = dif0(i);
    ter_u0(:, i) = [zeros(pad0, 1); prof_u0{i}];
    ter_v0(:, i) = [zeros(pad0, 1); prof_v0{i}];
    msk0(:, i) = [ones(pad0, 1); zeros(length(prof_u0{i}), 1)];
    
    pad3 = dif3(i);
    ter_u3(:, i) = [prof_u3{i}; zeros(pad3, 1)];
    ter_v3(:, i) = [prof_v3{i}; zeros(pad3, 1)];
    msk3(:, i) = [zeros(length(prof_u3{i}), 1); ones(pad3, 1)];
end

% Project velocities onto the line between the MTOCs
vec_t1t2 = [x2-x1, y2-y1];
vec_t1t2_norm = vec_t1t2/norm(vec_t1t2);

ter_u0 = ter_u0';
ter_v0 = ter_v0';
ter_u3 = ter_u3';
ter_v3 = ter_v3';
msk0 = msk0';
msk3 = msk3';

vel0 =  zeros(size(ter_u0));
vel3 =  zeros(size(ter_u3));

for i=1:size(ter_u0, 1)
    for j=1:size(ter_u0, 2)
        vec_uv = [ter_u0(i, j), ter_v0(i, j)];
        % Subtract velocity of midpoint between the MTOCs to highlight separation movement of the MTOCs
        vel0(i, j) = dot(vec_uv, vec_t1t2_norm) - dot(mid_vel(i, :), vec_t1t2_norm);
    end
end
vel0(msk0 == 1) = 0;

for i=1:size(ter_u3, 1)
    for j=1:size(ter_u3, 2)
        vec_uv = [ter_u3(i, j), ter_v3(i, j)];
        % Subtract velocity of midpoint between the MTOCs to highlight separation movement of the MTOCs
        vel3(i, j) = dot(vec_uv, vec_t1t2_norm) - dot(mid_vel(i, :), vec_t1t2_norm);
    end
end
vel3(msk3 == 1) = 0;

vel = [vel0, vel3];
msk = [msk0, msk3];

% Mask NaNs where no estimate of the flow field from PIVlab
msk(isnan(vel)) = 1;

% Plot velocity map with profiles overlayed
figure
colormap(redblue(100))
im = imagesc(vel, [-7.2 7.2]);
axis off

im.AlphaData = ~msk;

t_Y = 1:length(t1_X);
hold on
plot(t1_X, t_Y, 'k')
plot(t2_X, t_Y, 'k')
hold off

end