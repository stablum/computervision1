function [ output_args ] = harris_test( filename )
    IMRGB = imread(filename);
    IM = double(rgb2gray(IMRGB))/256;
    subplot(2,1,1);
    imshow(IM);
    sigma = 1;
    H = harris(IM, sigma);
    subplot(2,1,2);
    imshow(H*10);
end

