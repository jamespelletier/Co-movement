function overlay_pairs_all(stk, beads, pairs)

N = length(stk);

for t=1:N
    imshow(stk{t}, [570 1200])
    MTOC_circles(beads, t)
    overlay_pairs_zone(beads, pairs, t)
    overlay_pairs_nozone(beads, pairs, t)
    hgexport(gcf, ['ter/CC1cytoD_', num2str(t, '%0.02d'), '.jpg'], hgexport('factorystyle'), 'Format', 'jpeg');
end

end