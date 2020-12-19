function ter = crp_stack(ori, traj)

% Number of images in stack
N = length(ori);

% Width/height of ROI
s = 900;

% First MTOC position
cX = round(traj(1,1));
cY = round(traj(1,2));

% Loop through images
for i=1:N
    
    % Image from stack
    im = ori{i};
    
    % Crop upper left quadrant then rotate MTOC to top left
    % crp = im(cY-s:cY, cX-s:cX);
    % ter{i} = imrotate(crp, 180); %#ok<AGROW>
    
    % Crop lower left quadrant then rotate MTOC to top left
    % crp = im(cY:cY+s, cX-s:cX);
    % ter{i} = imrotate(crp, 90); %#ok<AGROW>
        
    % Crop upper right quadrant then rotate MTOC to top left
    % crp = im(cY-s:cY, cX:cX+s);
    % ter{i} = imrotate(crp, -90); %#ok<AGROW>
    
    % Crop lower right quadrant. MTOC already in top left
    crp = im(cY:cY+s, cX:cX+s);
    ter{i} = crp; %#ok<AGROW>
    
end

% Transpose stack to column
ter = ter';

end