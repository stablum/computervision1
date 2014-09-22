function imOut = compare_matlab_gaussian_filter(filename, sigma)
    imIn = double(imread(filename))/256;
    n0 = size(-ceil(3*sigma):1:+ceil(3*sigma),2);
    n = [ n0 n0 ];
    G = fspecial('gaussian',n,sigma);
    for i = 1:3
        imOut(:,:,i) = conv2(imIn(:,:,i),G,'same');
    end
end