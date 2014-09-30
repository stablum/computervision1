function plot_harris_and_red_points(H, coordinates )
    imshow(H*20);
    hold on
    for i = 1:size(coordinates,1),
        x = coordinates(i,1);
        y = coordinates(i,2);
        plot(y,x,'Color','r','LineStyle','+');
    end
    hold off
end
