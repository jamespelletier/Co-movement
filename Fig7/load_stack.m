function stk = load_stack()

% Number of images
N_im = 200;

% Load images into cell array
for i=1:2:N_im
    str = ['ori\c4t', num2str(i, '%0.03d'), '.tif'];
    stk{ceil(i/2)} = imread(str); %#ok<AGROW>
end

stk = stk';

end