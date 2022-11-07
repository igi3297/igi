#!/bin/bash

imgStart=$1
imgEnd=$2
audioCatLook=$3
audioTop=$4
audioBottom=$5

ffmpeg -y -framerate 1 \
-i "$imgStart" \
-i "$imgEnd" \
-i "$audioCatLook" \
-i "$audioTop" \
-i "$audioBottom" \
-filter_complex '
[0:v] loop=2:size=1:start=0 [v0];
[1:v] loop=2:size=1:start=0 [v1];
[3:a] adelay=1000 [a3];
[4:a] adelay=3000 [a4];
[2:a][a3][a4] amix=inputs=3 [outa];
[v0][v1] concat [outv]' \
-map '[outv]' -map '[outa]' \
meme.mp4




# ./generateMemeVideo.sh start.png end.png meme.wav 1.wav 2.wav