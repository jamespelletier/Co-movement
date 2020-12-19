function save_stack(stk)

% Save images in cell array as image sequence
N_timePoints = length(stk);
for i=1:N_timePoints
    imwrite(uint16(stk{i}), ['dcs_ffc_trns\c4t', num2str(2*i-1, '%0.03d'), '.tif'])
end

end