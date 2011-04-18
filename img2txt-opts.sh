# Set the font-width and font-height values to the width and height,
# respectively, of your terminal font (units don't matter, but pixels
# make sense).
#
# -W is the width in characters the image will take up on your terminal. You
# can specify -H instead, or both.
#
# --dither is the dithering method used. Turning it off looks best to me, but
# run img2txt with no arguments to see your other options.
#
# --format choses the output format. The only other useful option is 'ansi',
# which looks a little different.

I2T_OPTS="--font-width=7 --font-height=17 -W40 --format=utf8 --dither=none"
