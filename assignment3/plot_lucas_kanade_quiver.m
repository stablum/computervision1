function plot_lucas_kanade_quiver(v, frame_id, coordinates )
    v_x = v(frame_id,:,1)';
    v_y = v(frame_id,:,2)';
    xs = coordinates(:,1);
    ys = -coordinates(:,2);
    quiver(xs,ys,v_x,v_y);
end
