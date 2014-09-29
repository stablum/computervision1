function imOut = gaussianConv(image_path, sigma_x, sigma_y)
	gauss_x = gaussian(sigma_x);
	gauss_y = gaussian(sigma_y)';
	im = double(imread(image_path))/256;
	for i = 1:3
		im_curr_color = im(:,:,i);
		im_curr_color_convolved = conv2(im_curr_color, gauss_x);
		im_curr_color_convolved = conv2(im_curr_color_convolved, gauss_y);
        size(im_curr_color_convolved)
		imOut(:,:,i) = im_curr_color_convolved;
	end;
	imOut;
end