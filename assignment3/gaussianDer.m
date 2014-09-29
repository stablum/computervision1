function [ imOut Gd ] = gaussianDer(image_path, G, sigma)
	Gd = gaussianDerVec(G, sigma);
	im = double(imread(image_path));
	for i = 1:3
		im_curr_color = im(:,:,i);
		im_curr_color_convolved = conv2(im_curr_color, Gd);
		im_curr_color_convolved = conv2(im_curr_color_convolved, Gd');
		imOut(:,:,i) = im_curr_color_convolved;
	end;
end