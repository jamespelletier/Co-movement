function stk = load_stack()
% Outputs cell array from image stack

% Number of images
N = 10;

% Load images into cell array
for i=1:N
    str = ['E:\WH2019\20190621 e02 (LA DiI aINCENP interacting asters D- PLLgPEG control CC1 cytoD cytoDpCC1 extractB)\tif\t', num2str(i, '%0.02d'), 'xy30c3.tif'];
    stk{i} = imread(str); %#ok<AGROW>
end

end