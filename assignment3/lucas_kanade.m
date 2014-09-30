function [ v ] = lucas_kanade( Ix, Iy, It, center_x, center_y, window_size)
    min_x = center_x - floor(window_size/2);
    max_x = center_x + floor(window_size/2);
    min_y = center_y - floor(window_size/2);
    max_y = center_y + floor(window_size/2);

    xs = min_x:max_x;
    ys = min_y:max_y;
    
    A= [];
    b= [];
    for x = xs,
        for y = ys,
            
            if x < 1
                x = 1;
            end
            if x > size(Ix,2)
                x = size(Ix,2);
            end
            if y < 1
                y = 1;
            end
            if y > size(Iy,1)
                y = size(Iy,1);
            end
            
            A = [A; Ix(y,x) Iy(y,x)];
            b = [b; -It(y,x)];
        end
    end
    v = inv(A' * A) * A' * b;
end