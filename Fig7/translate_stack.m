function trns = translate_stack(stk, ff, traj)

dX = traj(:, 1)-traj(1, 1);
dY = traj(:, 2)-traj(1, 2);

% Dark current value
dc = 110.8;

N_timePoints = length(stk);

for i=1:N_timePoints
    im = double(stk{i});
    
    % Dark current subtraction
    sub = im - dc;
    
    % Flat field correction
    flt = sub./ff;
    
    % Translate image
    trns{i} = imtranslate(flt, -[dX(i) dY(i)]); %#ok<AGROW>
    
end

trns = trns';

end