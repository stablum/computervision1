function [ ret ] = harris_test( filename )
    IM1 = imread(filename);
    if size(size(IM1),2) == 3,
        IM = double(rgb2gray(IM1))/256;
    else
        % it's already grayscale
        IM = double(IM1)/256;
    end
    subplot(2,2,1);
    imshow(IM);
    sigma = 1;
    [H,Ix,Iy] = harris(IM, sigma);
    subplot(2,2,2);
    coordinates = harris_treshold_coordinates(H,0.2);
    plot_harris_and_red_points(H,coordinates);
    ret = 0;
    subplot(2,2,3);
    imshow(Ix);
    subplot(2,2,4);
    imshow(Iy);
end

