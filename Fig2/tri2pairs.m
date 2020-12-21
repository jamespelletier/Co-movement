function pruned = tri2pairs(triangles)

% triangles is an Nx3 matrix, where each row is a triangle in the Delaunay triangulation, and each element represents a bead index

% This function converts triangles to an Nx2 matrix of non-redundant pairs

% Enumerates all pairs, includes redundant pairs
pairs1 = triangles(:, 1:2);
pairs2 = triangles(:, 2:3);
pairs3 = cat(2, triangles(:, 1), triangles(:, 3));
pairs_ori = cat(1, pairs1, pairs2, pairs3);

% Put the smaller bead index in the first column
pairs_rows = sort(pairs_ori, 2);

% Sort pairs first on the second column (larger index) then on the first column (smaller index)
ps = sortrows(sortrows(pairs_rows, 2), 1);

% Keep one instance of each pair that appears twice
keep = zeros(size(ps, 1), 1);
for i=1:size(ps, 1)-1
    % Check if both bead indices the same
    if sum(ps(i,:) == ps(i+1,:)) == 2
        keep(i) = 1;
    end
end
col1 = ps(:, 1);
col2 = ps(:, 2);
% Use logical indexing to delete elements with keep = 0
col1(~logical(keep)) = [];
col2(~logical(keep)) = [];
pruned = cat(2, col1, col2);

end