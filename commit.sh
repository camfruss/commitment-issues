#!/bin/bash

REPO="$HOME/git/commitment-issues"
cd ${REPO}

FILE="out.log"
if [[ -f "$FILE" ]]; then
	rm "$FILE"
fi

LAT="42.3611"
LONG="-71.0571"
DATE=$(date +"%Y/%m/%d")

# Retreive max UV index assuming clear sky
UV_MAX=$(
	curl --get "https://api.open-meteo.com/v1/forecast?" \
	-d latitude=${LAT} \
	-d longitude=${LONG} \
	-d daily=uv_index_clear_sky_max | \
	jq '.daily.uv_index_clear_sky_max[0]'
)

# Exit if either API request failed
if [[ -z "$UV_MAX" ]]; then
    echo "Failed to fetch data"
	exit 1
else
	echo "UV Index: $UV_MAX"
fi
UV_MAX=$(printf "%.0f" "$UV_MAX")

# Make UV_MAX commits
for i in $(seq 1 2); #${UV_MAX});
do
	echo "Commit $i on $DATE" >> "$FILE"
	git commit -a -m "Updates for $DATE"
done

git push -u origin main

