function [ter, t1_X, t2_X] = kymo_density_image(t1, t2, stk)

N_timePoints = length(stk);

% t1 and t2 are MTOC trajectories
% stk is image sequence as cell array

% dst0: Distance from side of image closer to MTOC 1 to midpoint between MTOCs
% dst3: Distance from side of image closer to MTOC 2 to midpoint between MTOCs
% dst12: Distance between MTOCs
dst0 = zeros(N_timePoints, 1);
dst3 = zeros(N_timePoints, 1);
dst12 = zeros(N_timePoints, 1);

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
    
    im = stk{i};
    
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
    prof0{i} = improfile(im, [x0 xC], [y0 yC], dst0(i)); %#ok<AGROW>
    dst3(i) = round(sqrt((x3-xC)^2 + (y3-yC)^2));
    prof3{i} = improfile(im, [xC x3], [yC y3], dst3(i)); %#ok<AGROW>
end

% Pad profiles with zeros, so all profiles registered to the midpoint between the MTOCs
dst_max0 = max(dst0);
dst_max3 = max(dst3);

dif0 = dst_max0 - dst0;
dif3 = dst_max3 - dst3;

ter0 = zeros(dst_max0, N_timePoints);
ter3 = zeros(dst_max3, N_timePoints);

for i=1:N_timePoints
    pad0 = dif0(i);
    ter0(:, i) = [zeros(pad0, 1); prof0{i}];
    
    pad3 = dif3(i);
    ter3(:, i) = [prof3{i}; zeros(pad3, 1)];
end

% Stitch together profiles on either side of the midpoint between the MTOCs
ter0 = ter0';
ter3 = ter3';

ter = [ter0, ter3];

% Plot kymograph with profiles overlayed
imshow(ter, [800 1600])

t_Y = 1:size(ter, 1);
t1_X = dst_max0-dst12;
t2_X = dst_max0+dst12;
hold on
plot(t1_X, t_Y, 'r')
plot(t2_X, t_Y, 'r')
hold off

end