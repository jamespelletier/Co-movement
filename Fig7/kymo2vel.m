function vel = kymo2vel(kymo_n, sz, dr)

% Number of time points (rows)
N_timePoints = size(kymo_n, 1);

% Number of bins (columns)
N_bins = size(kymo_n, 2);

% Calculate total intensity in each bin (bin size increases with radius)
ti = zeros(N_timePoints, N_bins);
for i=1:N_timePoints
    ti(i, :) = double(kymo_n(i, :).*sz);
end

% Calculate cumulative total intensity
ti_cumsum = cumsum(ti, 2);

% Calculate flux toward MTOC
flux = zeros(N_timePoints-1, N_bins);
for i=1:N_timePoints-1
    flux(i, :) = ti_cumsum(i+1, :) - ti_cumsum(i, :);
end

% Calculate velocity
vel = zeros(size(flux));
for i=1:N_timePoints-1
    vel(i, :) = flux(i, :)./ti(i+1, :);
end

vel = vel*dr;

end