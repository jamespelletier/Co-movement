function stk = load_stack()
% Outputs cell array from image stack

% Number of images
st = 1;
N = 170;

% Load images into cell array
for i=st:st+N-1
    str = ['d20191109\cytoD\c3t', num2str(i, '%0.03d'), '.tif'];
    stk{i-st+1} = imread(str); %#ok<AGROW>
end

end