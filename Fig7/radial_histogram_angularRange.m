function ter = radial_histogram_angularRange(im, traj, theta_min, theta_max, dr, r_max)

% Initialize outputs

% Distance from MTOC
ter_r = (0:dr:r_max)';
% Average intensity in concentric shells away from the MTOC
ter_mean = zeros(length(ter_r), 1);
% Standard deviation of the intensity in concentric shells away from the MTOC
ter_sdev = zeros(length(ter_r), 1);
% Area of concentric shells away from the MTOC
ter_size = zeros(length(ter_r), 1);

% Generate matrices that represent X and Y coordinates with MTOC at origin
Nrows = size(im, 1);
Ncols = size(im, 2);
ctrX = round(traj(1, 1));
ctrY = round(traj(1, 2));
[X, Y] = meshgrid((1:Ncols)-ctrX, (Nrows:-1:1)-Nrows+ctrY);

% Generate matrix that represents angle with respect to MTOC (in radians), with branch cut at -pi/2 = 3*pi/2
theta = atan(Y./X);
theta(:, 1:ctrX-1) = theta(:, 1:ctrX-1) + pi;

% Generate matrix that represents distance from MTOC
pt = zeros(size(im));
pt(ctrY, ctrX) = 1;
dst = bwdist(pt);

% Convert theta_min and theta_max from degrees to radians
theta_min = theta_min*pi/180;
theta_max = theta_max*pi/180;

% Loop through concentric shells
for r=0:dr:r_max
    msk = (dst > r) & (dst < r + dr) & (theta > theta_min) & (theta < theta_max);
    val = im(msk == 1);
    ter_mean(r/dr+1) = mean(double(val(:)));
    ter_sdev(r/dr+1) = std(double(val(:)));
    ter_size(r/dr+1) = sum(msk(:));
end

% Output
ter = [ter_r, ter_mean, ter_sdev, ter_size];

end