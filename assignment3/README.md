Assignment 3
------------

Francesco Stablum 6200982

## Harris Corner Detector

The following commands will run the Harris corner detector on the test image and with treshold 0.1:

`harris_test('sphere1.ppm',0.1)`

This will display the original image converted to grayscale, the harris transformation, and the two derivatives in x and y. Please note that the image of the harris transformation is uniformly normalized between 0 and 1, so treshold values that make sense should be comprised within 0 and 1.

## Lucas-Kanade Algorithm

The following commands will display the two images and the optical flow, implemented with the `quiver` function:

`lucas_kanade_test('synth%d.pgm',15)`

`lucas_kanade_test('sphere%d.ppm',15)`

## Tracking

The arguments of the `tracking_test` function are:

 * a format string for frames filenames
 * total number of frames
 * Harris treshold
 * window size for Lucas-Kanade
 * sigma for the convolution kernels (gaussian and derivative)

Very good results for the *person_toy* sequence can be obtained with the following combination of parameters:

`tracking_test('person_toy/%08d.jpg',104,0.1,21,2)`

The following combination of parameters seems almost good for *pingpong*:

`tracking_test('pingpong/%04d.jpeg',52,0.1,21,1)`

For both tests the figures have been put together as a video:
`person_toy_tracked.mp4` and `pingpong_tracked.mp4`

At the end of both videos the tracking becomes increasingly noisy, due to the 
fact that the derivative in time space cannot be computed effectively if there 
aren't enough "lookahead" frames.

