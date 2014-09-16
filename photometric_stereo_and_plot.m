function photometric_stereo_and_plot()
    stepsize = 32;
    [albedo, normals, height, p, q] = photometric_stereo;
    'finished photometric stereo'
    %imshow(albedo);
    stepstuff = 1:stepsize:512;
    [X Y] = meshgrid(stepstuff,stepstuff);
    X = X(:);
    Y = Y(:);
    u = normals(stepstuff,stepstuff,1);
    u = u(:);
    v = normals(stepstuff,stepstuff,2);
    v = v(:);
    w = normals(stepstuff,stepstuff,3);
    w = w(:);
    Z = height(stepstuff,stepstuff);
    Z = Z(:);
    size(Z)
    size(u)
    
    subplot(2,3,1);
    imshow((1+p)/2);
    subplot(2,3,2);
    imshow((1+q)/2);
    subplot(2,3,4);
    imshow((1+(height/256))/2);
    p(256,:)
    subplot(2,3,5);
    quiver(X,Y,u,v)
    subplot(2,3,6);
    quiver3(X,Y,Z,u,v,w);
end