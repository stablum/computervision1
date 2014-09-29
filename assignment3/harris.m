function [ ret ] = harris( IM, sigma )
    size(IM)
    G = gaussian(1);
    Gd = gaussianDerVec(G, sigma);
    size(Gd)
    Ix = conv2(IM, Gd,'same');
    Ix2 = Ix .* Ix;
    tmp = conv2(Ix2,G,'same');
    A= conv2(tmp,G','same');
    
    Iy = conv2(IM, Gd','same');
    Iy2 = Iy .* Iy;
    tmp = conv2(Iy2,G,'same');
    C = conv2(tmp,G','same');
    
    Ixy = Ix .* Iy;
    tmp = conv2(Ixy,G,'same');
    B = conv2(tmp,G','same');

    for x = 1:size(IM, 2),
        for y = 1:size(IM,1),
            %Q = [ 
            %        A(y,x) B(y,x) ;
            %        B(y,x) C(y,x) 
            %    ];
            %lambda = eig(Q)
            H(y,x) = (A(y,x)*C(y,x) - B(y,x).^2) - 0.004*(A(y,x) + C(y,x)).^2;
        end,
    end
    
    Hmin = min(min(H));
    Hmax = max(max(H));
    Hnorm = (H - Hmin)/(Hmax - Hmin)
    ret = Hnorm;
end

