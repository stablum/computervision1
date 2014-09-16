function [albedo, normals, height, p, q] = photometric_stereo( )
    % obtain many images in a fixed view under different illuminants
    for i = 1:5,
        filename = sprintf('sphere%d.png',i);
        images(:,:,i) = double(imread(filename));
    end
    
    resolution = size(images(:,:,1))
    
    
    % Determine the matrix V from source and camera information.
    % the matrix V is composed by n rows. 
    % Each row of V is a vector V_i which is a property of the illumination
    % and of the camera.
    % V_i is defined as the product between 'k', the constant connecting
    % the camera response to the input radiance, and S_i.
    % S_i is the source vector.
    % The source vector S_i is a vector from every point P to the light
    % source, which varies for each image.
    % The source vectors are stored as rows into an S matrix.
    k = 1;
    S=[ 0,0,1;
        1,1,1;
        -1,1,1;
        1,-1,1;
        -1,-1,1;
      ]'; % please note the traspose operator: there is one S_i for each *column*
  
    V = (k * S)'; % should be a n times 3 matrix
    
    % for each point in the image array
    [X,Y] = meshgrid(1:resolution(1),1:resolution(2));
    for xy = [ X(:) Y(:) ]',
        x = xy(1);
        y = xy(2);
        tmp = images(x,y,:);
        i = tmp(:);
        diagI = diag(i);
        % the calculation of A and b has been inspired by
        % http://pages.cs.wisc.edu/~csverma/CS766_09/Stereo/NormalMap.m
        A = V' * V;
        b = V' * i;
        g = inv(A) * b;
        albedo(x,y) = norm(g);
        if albedo(x,y) == 0,
            N = [0,0,0]';
        else
            N = g/albedo(x,y);
        end
        normals(x,y,:) = N;
        if N(3) == 0,
            p(x,y) = 0;
            q(x,y) = 0;
        else
            p(x,y) = N(1)/N(3);
            q(x,y) = N(2)/N(3);
        end
    end
    
    height = zeros(resolution);
    %x = 1;
    %prev = height(x,1);
    %for y = 1:resolution(2),
    %    height(x,y) = prev + q(x,y);
    %    prev = height(x,y);
    %end
    for y = 1:resolution(2),
        prev = height(1,y);
        for x = 2:resolution(1),
            height(x,y) = prev - p(x,y);
            prev = height(x,y);
        end
    end
    
end