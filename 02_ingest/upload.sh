#!/bin/bash
export BUCKET=${BUCKET:=fiery-bit-266210-ds40}
echo "Uploading to bucket $BUCKET..."
gsutil -m cp *.csv gs://$BUCKET/flights/raw
#gsutil -m acl ch -R -g google.com:R gs://$BUCKET/flights/raw
