function flux = kymo2flux(kymo, sz)

% Number of time points (rows)
N_timePoints = size(kymo, 1);

% Number of bins corresponding to concentric shells away from the MTOC (columns)
N_bins = size(kymo, 2);

% Cumulative intensity away from the MTOC
kymo_cs = cumsum(kymo, 2);

% Initialize and calculate flux as difference in cumulative intensity between subsequent time points
flux = zeros(N_timePoints-1, N_bins);
for i=1:N_timePoints-1
    flux(i, :) = (kymo_cs(i+1, :) - kymo_cs(i, :)).*sz;
end

end