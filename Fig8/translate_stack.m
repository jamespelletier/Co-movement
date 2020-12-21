function stk_trans = translate_stack(stk, traj)
% Outputs translated stack so bead stationary

% Number of images
N = length(stk);

% Calculate the displacement relative to the initial bead position
trans = zeros(size(traj));
trans(:, 1) = traj(:, 1) - traj(1, 1);
trans(:, 2) = traj(:, 2) - traj(1, 2);

% Output translated stack as new cell array
for i=1:N
    % Translate by negative the displacement relative to the initial bead position
    stk_trans{i} = imtranslate(stk{i}, -[trans(i, 1), trans(i, 2)]); %#ok<AGROW>
end

end