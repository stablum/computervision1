function lucas_kanade_test(fmt)
    NUMFRAMES = 2;
    WINDOWSIZE = 15;
    HARRIS_TRESHOLD = 0.1;
    sigma = 1;
    G = gaussian(sigma);
    Gd = gaussianDerVec(G, sigma);

    for i=1:NUMFRAMES
        filename = sprintf(fmt,i);
        IM1 = imread(filename);
        if size(size(IM1),2) == 3,
            IM = double(rgb2gray(IM1))/256;
        else
            % it's already grayscale
            IM = double(IM1)/256;
        end
        
        Ix = conv2(IM, Gd,'same');
        Iy = conv2(IM, Gd','same');
        IMs(:,:,i+1) = IM;
        Ixs(:,:,i+1) = Ix;
        Iys(:,:,i+1) = Iy;
    end
    
    xs = 1:size(IMs,2);
    ys = 1:size(IMs,1);
    for x = xs,
        for y = ys,
            coresample = reshape(IMs(y,x,:),1,[]);
            It_curr = conv(coresample,Gd,'same');
            Its(y,x,:) = It_curr;
        end
    end
    
    'now doing the lucas kanade for each frame'
    for i=1:NUMFRAMES
        Ix = Ixs(:,:,i);
        Iy = Iys(:,:,i);
        It = Its(:,:,i);
        
        % FIXME: Ix and Iy are recomputed
        [H,Ix2,Iy2] = harris(IM, sigma);
        coordinates = harris_treshold_coordinates(H,HARRIS_TRESHOLD);
        
        for j = 1:size(coordinates,1)
            x = coordinates(j,1)
            y = coordinates(j,2)
            
            v(i,j,:) = lucas_kanade(Ix,Iy,It,x,y,WINDOWSIZE);
        end
    end
    subplot(2,1,1)
    plot_harris_and_red_points(H, coordinates )
    subplot(2,1,2)
    plot_lucas_kanade_quiver(v,coordinates);
end