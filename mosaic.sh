#!/bin/bash

# Name: mosaic.sh
# Author: Andy Torres
# Version: 1.0
# Description: This script is to start the FFMPEG video encoder and build a mosaic from the Opree
# the idea is to consume the rtmp output from a third location like a android box  using VLC


if (( $EUID != 0 )); then
    echo "Please run this script with SUDO"
    exit
fi

echo "Stopping and starting NGINX"

/usr/local/nginx/sbin/nginx -s stop
/usr/local/nginx/sbin/nginx

echo "Done..."
sleep 2
echo "Starting the ffmpeg and RTMP output"
echo "Be patient this take a little to finish"
sleep 2


/usr/bin/ffmpeg -thread_queue_size 2048 -analyzeduration 10M -probesize 10M -re -i http://10.56.32.61/0.ts -i http://10.56.32.62/0.ts -i http://10.56.32.63/0.ts -i http://10.56.32.64/0.ts -i http://10.56.32.65/0.ts -i http://10.56.32.66/0.ts -i http://10.56.32.67/0.ts -i http://10.56.32.68/0.ts -i http://10.56.32.69/0.ts -i http://10.56.32.70/0.ts -i http://10.56.32.71/0.ts -i http://10.56.32.72/0.ts -i http://10.56.32.73/0.ts -i http://10.56.32.74/0.ts -i http://10.56.32.75/0.ts -i http://10.56.32.76/0.ts -filter_complex "
nullsrc=size=1920x1080 [base];
[0:v] setpts=PTS-STARTPTS, scale=480x270 [video1];
[1:v] setpts=PTS-STARTPTS, scale=480x270 [video2];
[2:v] setpts=PTS-STARTPTS, scale=480x270 [video3];
[3:v] setpts=PTS-STARTPTS, scale=480x270 [video4];
[4:v] setpts=PTS-STARTPTS, scale=480x270 [video5];
[5:v] setpts=PTS-STARTPTS, scale=480x270 [video6];
[6:v] setpts=PTS-STARTPTS, scale=480x270 [video7];
[7:v] setpts=PTS-STARTPTS, scale=480x270 [video8];
[8:v] setpts=PTS-STARTPTS, scale=480x270 [video9];
[9:v] setpts=PTS-STARTPTS, scale=480x270 [video10];
[10:v] setpts=PTS-STARTPTS, scale=480x270 [video11];
[11:v] setpts=PTS-STARTPTS, scale=480x270 [video12];
[12:v] setpts=PTS-STARTPTS, scale=480x270 [video13];
[13:v] setpts=PTS-STARTPTS, scale=480x270 [video14];
[14:v] setpts=PTS-STARTPTS, scale=480x270 [video15];
[15:v] setpts=PTS-STARTPTS, scale=480x270 [video16];
[base][video1] overlay=shortest=0 [tmp1];
[tmp1][video2] overlay=shortest=0:x=480 [tmp2];
[tmp2][video3] overlay=shortest=0:x=960 [tmp3];
[tmp3][video4] overlay=shortest=0:x=1440 [tmp4];
[tmp4][video5] overlay=shortest=0:y=270 [tmp5];
[tmp5][video6] overlay=shortest=0:x=480:y=270 [tmp6];
[tmp6][video7] overlay=shortest=0:x=960:y=270 [tmp7];
[tmp7][video8] overlay=shortest=0:x=1440:y=270 [tmp8];
[tmp8][video9] overlay=shortest=0:y=540 [tmp9];
[tmp9][video10] overlay=shortest=0:x=480:y=540 [tmp10];
[tmp10][video11] overlay=shortest=0:x=960:y=540 [tmp11];
[tmp11][video12] overlay=shortest=0:x=1440:y=540 [tmp12];
[tmp12][video13] overlay=shortest=0:y=810 [tmp13];
[tmp13][video14] overlay=shortest=0:x=480:y=810 [tmp14];
[tmp14][video15] overlay=shortest=0:x=960:y=810 [tmp15];
[tmp15][video16] overlay=shortest=0:x=1440:y=810
" -c:v libx264 -r 25 -crf 23 -preset ultrafast -tune zerolatency -an -f flv rtmp://10.56.32.26/live/mosaic
