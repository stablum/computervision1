function test_sift(image_path)
    addpath('sift');
	im = double(rgb2gray(imread(image_path)));
    size(im)
    [frames,desc] = sift(im);
end
