function test_tracking(fmt,numframes,harris_treshold,windowsize,sigma)
    G = gaussian(sigma);
    Gd = gaussianDerVec(G, sigma);

    'calculating derivative with regard to x and y'
    for i=1:numframes
        filename = sprintf(fmt,i);
        IM1 = imread(filename);
        IM = double(rgb2gray(IM1))/256;
        Ix = conv2(IM, Gd,'same');
        Iy = conv2(IM, Gd','same');
        IMs(:,:,i) = IM;
        Ixs(:,:,i) = Ix;
        Iys(:,:,i) = Iy;
    end
    
    xs = 1:size(IMs,2);
    ys = 1:size(IMs,1);
    'calculating derivative with regard to time'
    for x = xs,
        for y = ys,
            coresample = reshape(IMs(y,x,:),1,[]);
            It_curr = conv(coresample,Gd,'same');
            Its(y,x,:) = It_curr;
        end
    end
    
    'calculating harris on the first frame'
    % FIXME: Ix and Iy are recomputed
    [H,Ix2,Iy2] = harris(IMs(:,:,1), sigma);
    coordinates = harris_treshold_coordinates(H,harris_treshold);
    
    'number of coordinates of found tracking points:'
    size(coordinates,1)
    xs = coordinates(:,1)';
    ys = coordinates(:,2)';
    'now doing the lucas kanade for each frame'
    for i=1:numframes
        IM = IMs(:,:,i);
        Ix = Ixs(:,:,i);
        Iy = Iys(:,:,i);
        It = Its(:,:,i);
        
        'lucas kanade'
        for j = 1:size(xs,2)
            x = xs(j);
            y = ys(j);
            curr_v = lucas_kanade(Ix,Iy,It,round(x),round(y),windowsize);
            v(i,j,:) = curr_v;
        end
        
        'apply differentials to coordinates'
        for j = 1:size(xs,2)
            
            xs(j) = xs(j) + v(i,j,1);
            
            %x out of valid range?
            if xs(j) > size(IM,2)
                xs(j) = size(IM,2);
            end
            if xs(j) < 1
                xs(j) = 1;
            end
            
            ys(j) = ys(j) + v(i,j,2);
            
            %y out of valid range?
            if ys(j) > size(IM,1)
                ys(j) = size(IM,1);
            end
            if ys(j) < 1
                ys(j) = 1;
            end
        end
        
        subplot(1,2,1)
        plot_image_and_red_points(IM,round(xs),round(ys));
        subplot(1,2,2)
        plot_lucas_kanade_quiver(v, i, [xs' ys']);
        pause(0.1);
    end
end