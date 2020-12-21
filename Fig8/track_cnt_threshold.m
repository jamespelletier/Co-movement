function cnt = track_cnt_threshold(stk)

N = length(stk);

% Threshold calculated as linear interpolation between initial (i) and final (f) values
i = 7000;
f = 5000;
del = (f-i)/N;
thr_val = i:del:f;

im = stk{1};
%red = cat(3, ones(size(im)), zeros(size(im)), zeros(size(im)));
%pause on

cnt = zeros(N, 2);

[Y, X] = ndgrid(1:size(im, 1), 1:size(im, 2));

% Loop through image sequence
for i=1:N
    im = imgaussfilt(stk{i}, 3);
    
    % Threshold image
    thr_im = im > thr_val(i);
    
    % X and Y coordinates of all pixels in the thresholded object
    X_thr = X(thr_im);
    Y_thr = Y(thr_im);
    
    % Centroid of thresholded object
    cnt(i, :) = [mean(X_thr(:)), mean(Y_thr(:))];
    
    %{
    imshow(im, [])
    hold on
    h_red = imshow(red);
    plot(cnt(i, 1), cnt(i, 2), 'r*')
    hold off
    set(h_red, 'AlphaData', 0.2*thr_im)
    pause
    %}
    
end

%pause off

end