function lucas_kanade_test(fmt,windowsize)
    NUMFRAMES = 2;
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
        IMs(:,:,i) = IM;
        Ixs(:,:,i) = Ix;
        Iys(:,:,i) = Iy;
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

    coord1d = ((1:17)*15)-7;
    [xs,ys] = meshgrid(coord1d,coord1d);
    xs = reshape(xs,1,[])
    ys = reshape(ys,1,[]);
    coordinates = [xs' ys'];

    'now doing the lucas kanade for each frame'
    for i=1:NUMFRAMES
        Ix = Ixs(:,:,i);
        Iy = Iys(:,:,i);
        It = Its(:,:,i);
        
        % FIXME: Ix and Iy are recomputed
        %[H,Ix2,Iy2] = harris(IM, sigma);
        %coordinates = harris_treshold_coordinates(H,HARRIS_TRESHOLD);
                
        for j = 1:size(xs,2)
            x = xs(j);
            y = ys(j);
            curr_v = lucas_kanade(Ix,Iy,It,x,y,windowsize);
            v(i,j,:) = curr_v;
        end
    end
    for frame_id = 1:NUMFRAMES
        base_index = (frame_id-1) * 2;
        subplot(2,2,base_index + 1)
        imshow(IMs(:,:,frame_id));
        %plot_harris_and_red_points(H, coordinates )
        subplot(2,2,base_index + 2)
        plot_lucas_kanade_quiver(v, frame_id, coordinates);
    end
    
end