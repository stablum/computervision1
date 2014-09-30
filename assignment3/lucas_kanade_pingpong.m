function lucas_kanade_pingpong()
    NUMFRAMES = 53;
    sigma = 1;
    G = gaussian(sigma);
    Gd = gaussianDerVec(G, sigma);

    for i=0:(NUMFRAMES-1)
        filename = sprintf('pingpong/%04d.jpeg',i);
        IM1 = imread(filename);
        IM = double(rgb2gray(IM1))/256;
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
        lucas_kanade(Ix,Iy,It,10,10,3)
    end
end