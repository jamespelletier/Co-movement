function pairs = delaunay_pairs(beads)

% Determines neighboring beads based on Delaunay triangulation of beads present in the first image
Nbeads = length(beads);
Xall = [];
Yall = [];
for i=1:Nbeads
    bead = beads(i);
    if bead.t(1) == 1
        Xall = [Xall; bead.x(1)]; %#ok<AGROW>
        Yall = [Yall; bead.y(1)]; %#ok<AGROW>
    end
end

% Calculate and Delaunay triangles to non-redundant pairs
DT = delaunayTriangulation(Xall, Yall);
triangles = DT.ConnectivityList;
pairs = tri2pairs(triangles);

end