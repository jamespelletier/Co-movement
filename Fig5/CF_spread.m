function sigma = CF_spread(params, tdata)

% Diffusion coefficient
D = params(1);

% Time at which fluorescein photoreleased
tau = params(2);

% Function for approximating spread of photoreleased fluorescein
sigma = sqrt(2*D*(tdata - tau));