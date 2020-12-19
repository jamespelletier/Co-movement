function traj = track_bead_manual(stk)

% Number of images
N = length(stk);

% Initialize bead trajectory
traj = zeros(N, 2);

% Half width of zoomed images shown to user
s = 30;

% Initial bead position
% Part 1
% xst = 1079;
% yst = 982;

% Part 2
xst = 565;
yst = 986;

xlo = xst-s;
xhi = xst+s;
ylo = yst-s;
yhi = yst+s;

% Loop through images
for i=12:N
    % Show image
    imshow(stk{i}, [200 1500])
    
    % Zoom to bead 
    set(gca, 'xlim', [xlo xhi])
    set(gca, 'ylim', [ylo yhi])
    
    % User clicks on bead
    [traj(i, 1), traj(i, 2)] = getpts;
    
    % Update bounds of zoomed image based on current bead position
    xlo = traj(i, 1)-s;
    xhi = traj(i, 1)+s;
    ylo = traj(i, 2)-s;
    yhi = traj(i, 2)+s;
end

end