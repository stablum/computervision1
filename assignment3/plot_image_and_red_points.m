function plot_image_and_red_points(IM, xs, ys )
    imshow(IM);
    hold on
    
    for i = 1:size(xs,2),
        x = xs(i);
        y = ys(i);
        plot(x,y,'Color','r','LineStyle','+');
    end
    hold off
end
