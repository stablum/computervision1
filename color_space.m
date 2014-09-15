function color_space(filename, type)
	Im = imread(filename);
	imshow(Im);
	
	sumRGB = sum(Im,3);
	
	for channel = 0:size(Im,3),
		tmp = Im(:,:,channel)
		normChannel = tmp ./ sumRGB;
		normIm(:,:,channel) = normChannel;
	end
	normIm
	imshow(normIm);
end
