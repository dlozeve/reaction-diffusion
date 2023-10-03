#!/usr/bin/env bash
set -euo pipefail

mkdir -p out
bqn grayscott.bqn
# first image is often bad
rm out/step00000.pnm
# convert all to PNG
parallel --jobs 8 "pnmtopng {} > {.}.png" ::: out/*.pnm
# generate video
ffmpeg -y -framerate 30 -pattern_type glob -i 'out/*.png' -r 30 -vf scale=500:-1 out.mp4
