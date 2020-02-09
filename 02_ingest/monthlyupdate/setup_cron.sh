#!/bin/bash

echo "./setup_cron.sh  fiery-bit-266210-ds40 us-central1 ingest_flights_6gSSzRcgC3low8h1rhdZMuReYO8OI9fn  0Gdv7YywE0NEUVdtmNHv4a7Ffk6MpEf1"
if [ "$#" -ne 4 ]; then
    echo "Usage: ./setup_cron.sh  destination-bucket-name compute-region ingest-url  personal-access-token"
    echo "   eg: ./setup_cron.sh  cloud-training-demos-ml us-central1 ingest_flights_udwaxx86mVygAmOazUcijW8zBXWNxEVM  DI8TWPzTedNF0b3B8meFPxXSWw6m3bKG"
    exit
fi

PROJECT=$(gcloud config get-value project)
BUCKET=$1
REGION=$2
URLPATH=$3
TOKEN=$4

URL="https://${REGION}-${PROJECT}.cloudfunctions.net/${URLPATH}"
echo {\"bucket\":\"${BUCKET}\", \"token\":\"${TOKEN}\"} > /tmp/message_monthlyupdate

gcloud pubsub topics create cron-topic
gcloud pubsub subscriptions create cron-sub --topic cron-topic
#
#       --schedule="8 of month 10:00" \
#

#exit
# gcloud beta scheduler jobs delete monthlyupdate

gcloud beta scheduler jobs create http monthlyupdate \
       --schedule="every 1 mins" \
       --uri=$URL \
       --headers="Content-Type=application/json" \
       --max-backoff=7d \
       --max-retry-attempts=5 \
       --max-retry-duration=3h \
       --min-backoff=1h \
       --time-zone="US/Eastern" \
       --message-body-from-file=/tmp/message_monthlyupdate
