function [ coordinates ] = harris_treshold_coordinates( H, treshold )

    [coordinates(:,2),coordinates(:,1)] = find(H > treshold);
end

