1
-

Usage: from MATLAB's console, run the function `photometric_stereo_and_plot` without arguments. The upper plots are the values of `p` and `q`.

The bottom plots are: height displayed as an image (white = high, black = low), 2d quiver, and 3d quiver. Unfortunately the height is stil miscalculated.

2
-

Run:
    
    colorspace('bricks.jpg','opponent');
    colorspace('bricks.jpg','rgb');
    colorspace('bricks.jpg','hsv');


