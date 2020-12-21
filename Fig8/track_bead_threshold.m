function bead = track_bead_threshold(stk)

% Initialize trajectory
x = 753;
y = 1184;

pct = 0.5;
gauss = imgaussfilt(stk{1}, 2);
thr_val = gauss(y, x)*pct;

% Minimum distance from centrosome
minD = 60;

% Centroid position
cX = 963.6;
cY = 1051.9;

% Max displacement of kernel to define search area
s = 40;

% Crop to kernel
kernel = stk{1}(y-s:y+s, x-s:x+s);

% Threshold kernel
thr_im = kernel > thr_val;

% Calculate centroid of binary object
cc = bwconncomp(thr_im);
stru = regionprops(cc);
cnts = cat(1, stru.Centroid);
dsp = sqrt((cnts(:, 1)-s).^2 + (cnts(:, 2)-s).^2);
[~, stru_idx] = min(dsp);
cnt = stru(stru_idx).Centroid;
x = x+cnt(1)-s-1;
y = y+cnt(2)-s-1;

% Initialize output
ter = [x, y];
dst = sqrt((x-cX)^2 + (y-cY)^2);
gauss = imgaussfilt(kernel, 2);
thr_val = gauss(round(cnt(2)), round(cnt(1)))*pct;

N = length(stk);

red = cat(3, ones(size(kernel)), zeros(size(kernel)), zeros(size(kernel)));

% Loop thru remaining frames
for t=2:N
    % Overwrite kernel
    kernel = stk{t}(round(y)-s:round(y)+s, round(x)-s:round(x)+s);
    
    % Threshold kernel
    thr_im = kernel > thr_val;
    
    % Calculate centroid of binary object as closest to previous position
    cc = bwconncomp(thr_im);
    stru = regionprops(cc);
    cnts = cat(1, stru.Centroid);
    dsp = sqrt((cnts(:, 1)-s).^2 + (cnts(:, 2)-s).^2);
    [~, stru_idx] = min(dsp);
    cnt = stru(stru_idx).Centroid;
    
    %
    % Plot
    imshow(kernel, [0 3500])
    text(3, 5, ['Idx: ', num2str(t)], 'FontSize', 14, 'Color', 'r')
    set(gcf, 'Position', [437 200.2 585.6 581.2])
    hold on
    h_red = imshow(red);
    hold off
    set(h_red, 'AlphaData', 0.2*thr_im)
    hold on
    plot(cnt(1), cnt(2), 'r*')
    hold off
    
    % Offer to correct
    [x_corr, y_corr] = getpts;
    if ~isempty(x_corr)
        x = x+x_corr-s-1;
        y = y+y_corr-s-1;
    else
        x = x+cnt(1)-s-1;
        y = y+cnt(2)-s-1;
    end
    %}
    
    %x = x+cnt(1)-s-1;
    %y = y+cnt(2)-s-1;
    
    %{
    if ~isempty(x_corr)
        dsp = sqrt((cnts(:, 1)-x_corr).^2 + (cnts(:, 2)-y_corr).^2);
        [~, stru_idx] = min(dsp);
        cnt = stru(stru_idx).Centroid;
        x = x+cnt(1)-s-1;
        y = y+cnt(2)-s-1;
    end
    %}
    
    ter = [ter; x, y]; %#ok<AGROW>
    dst = [dst; sqrt((x-cX)^2 + (y-cY)^2)]; %#ok<AGROW>
    gauss = imgaussfilt(kernel, 2);
    thr_val = gauss(round(cnt(2)), round(cnt(1)))*pct;
    
    % Stop tracking when bead within certain distance (minD) of MTOC
    if dst(end) < minD
        bead.traj = ter;
        bead.dst = dst;
        imshow(stk{1}, [])
        hold on
        plot(ter(:, 1), ter(:, 2), 'r.-')
        hold off
        return
    end
end

bead.traj = ter;
bead.dst = dst;

close all
imshow(stk{1}, [0 5000])
hold on
plot(ter(:, 1), ter(:, 2), 'r.-')
hold off

end