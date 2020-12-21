function beads = track_bead_manual(stk_aINCENP, stk_ER, idx01, beads)
% Outputs bead trajectory from user clicks

% This code is intended to deal with beads that enter or exit the ROI during the stack

% Levels to show images
lo_aINCENP = 600;
hi_aINCENP = 1000;
lo_ER = 900;
hi_ER = 2300;

% Show first image with previous bead trajectories
%imshow(stk_aINCENP{idx01}, [lo_aINCENP hi_aINCENP])
imshow(stk_aINCENP{idx01}, [])
overlay_bead_trajectory_all(beads)

% Initial bead position
[x_tmp, y_tmp] = getpts;

% Half width of zoomed images shown to user
s = 250;

% Calculate bounds of first image shown to user
xlo = x_tmp-s;
xhi = x_tmp+s;
ylo = y_tmp-s;
yhi = y_tmp+s;

% Number of images
N = length(stk_aINCENP);

% Loop through images
for i=idx01:N
    % Show image
    %imshow(stk_aINCENP{i}, [lo_aINCENP hi_aINCENP])
    imshow(stk_aINCENP{i}, [])
    
    % Zoom to bead 
    set(gca, 'xlim', [xlo xhi])
    set(gca, 'ylim', [ylo yhi])
    
    % User clicks on bead
    [x_tmp, y_tmp] = getpts;
    
    if isempty(x_tmp)
        break
    else
        % Write to output
        t(i-idx01+1) = i; %#ok<AGROW>
        x(i-idx01+1) = x_tmp; %#ok<AGROW>
        y(i-idx01+1) = y_tmp; %#ok<AGROW>
        
        % Update bounds of zoomed image based on current bead position
        xlo = x_tmp-s;
        xhi = x_tmp+s;
        ylo = y_tmp-s;
        yhi = y_tmp+s;
    end
    
end

bead.t = t;
bead.x = x;
bead.y = y;

% Show new bead trajectory with previous bead trajectories
close all
%imshow(stk_ER{idx01}, [lo_ER hi_ER])
imshow(stk_ER{idx01}, [])
overlay_bead_trajectory_all(beads)
overlay_bead_trajectory_blue(bead)

% Ask user whether to include new bead trajectory
str = input('Include new bead trajectory? Y/N\n', 's');
if str == 'Y'
    beads = [beads; bead];
end

close all

end