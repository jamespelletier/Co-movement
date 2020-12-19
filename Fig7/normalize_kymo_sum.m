function kymo_n = normalize_kymo_sum(kymo, sz)

% Initialize normalized kymograph
kymo_n = double(zeros(size(kymo)));

% Calculate total intensity of first time point
ti01 = sum(kymo(1, :).*sz);

% Loop through time points
for i=1:size(kymo, 1)
    
    % Calculate total intensity
    ti = sum(kymo(i, :).*sz);
    
    % Normalize to total intensity of first time point
    kymo_n(i, :) = double(kymo(i, :))/ti*ti01;
end

end