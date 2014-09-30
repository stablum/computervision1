function [ coordinates ] = harris_treshold_coordinates( H, treshold )

    [coordinates(:,1),coordinates(:,2)] = find(H > treshold);
end

