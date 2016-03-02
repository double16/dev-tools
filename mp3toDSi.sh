#!/bin/bash

which ffmpeg >/dev/null || exit 1

find . -iname "*.mp3" | while read F; do
	ffmpeg -y -i "${F}" -c:a libfaac "${F%.mp3}.m4a" </dev/null && rm "${F}"
done

