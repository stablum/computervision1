function [ output_args ] = harris_test( filename )
    IM1 = imread(filename);
    if size(size(IM1)) == 3,
        IM = double(rgb2gray(IM1))/256;
    else
        % it's already grayscale
        IM = double(IM1)/256;
    subplot(2,1,1);
    imshow(IM);
    sigma = 1;
    H = harris(IM, sigma);
    subplot(2,1,2);
    imshow(H*10);
end

