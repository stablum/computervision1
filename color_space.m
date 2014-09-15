function color_space(filename, type)
	Im = imread(filename);
	
    if strcmp(type, 'rgb'),
        convertedIm = color_space_rgb(Im);
    elseif strcmp(type, 'opponent'),
        convertedIm = color_space_opponent(Im);
    elseif strcmp(type, 'hsv'),
        convertedIm = color_space_hsv(Im);
    end

    for channel = 1:size(Im,3),
        subplot(3,3,3 + channel);
        tmp = zeros(size(Im));
        tmp(:,:,channel) = double(Im(:,:,channel))/256;
        subimage(tmp);
        subplot(3,3,6 + channel);
        tmpNorm = zeros(size(convertedIm));
        tmpNorm(:,:,channel) = double(convertedIm(:,:,channel));
        subimage(tmpNorm);
    end
    subplot(3,3,1), subimage(Im);
    subplot(3,3,2), subimage(convertedIm);
    
end

function convertedIm = color_space_rgb(Im)
	sumRGB = sum(Im,3);
    subplot(3,3,3), subimage(sumRGB ./ (256*3));
	
	for channel = 1:size(Im,3),
		tmp = double(Im(:,:,channel));
		normChannel = tmp ./ sumRGB;
		convertedIm(:,:,channel) = normChannel;
    end
end

function convertedIm = color_space_opponent(Im)
	%sumRGB = sum(Im,3);
    %subplot(3,3,3), subimage(sumRGB ./ (256*3));
	
	
	R = double(Im(:,:,1))/256;
    G = double(Im(:,:,2))/256;
    B = double(Im(:,:,3))/256;
    O1 = (R - G) ./ sqrt(2);
    O2 = (R + G - (2 * B)) ./ sqrt(6);
    O3 = (R + G + B) ./ sqrt(3);
	convertedIm(:,:,1) = O1;
    convertedIm(:,:,2) = O2;
    convertedIm(:,:,3) = O3;
end

function convertedIm = color_space_hsv(Im)
    convertedIm = rgb2hsv(Im);
end