#!/bin/bash

if [ "$#" -ne 4 ]; then
    echo "Usage: ./call_cf.sh  destination-bucket-name compute-region ingest-url  personal-access-token"
    echo "   eg: ./call_cf.sh  cloud-training-demos-ml us-central1 ingest_flights_udwaxx86mVygAmOazUcijW8zBXWNxEVM  DI8TWPzTedNF0b3B8meFPxXSWw6m3bKG"
    exit
fi

PROJECT=$(gcloud config get-value project 2>/dev/null)
BUCKET=$1
REGION=$2
URLPATH=$3
TOKEN=$4

URL="https://${REGION}-${PROJECT}.cloudfunctions.net/${URLPATH}"

echo {\"year\":\"2015\"\,\"month\":\"03\"\,\"bucket\":\"${BUCKET}\", \"token\":\"${TOKEN}\"} > /tmp/message
cat /tmp/message
#echo "curl -X POST \"https://${REGION}-${PROJECT}.cloudfunctions.net/$URL\" -H \"Content-Type:application/json\" --data-binary @/tmp/message"
#curl -X POST "https://${REGION}-${PROJECT}.cloudfunctions.net/$URL" -H "Content-Type:application/json" --data-binary @/tmp/message
echo "curl -X POST \"$URL\" -H \"Content-Type:application/json\" --data-binary @/tmp/message"
curl -X POST "$URL" -H "Content-Type:application/json" --data-binary @/tmp/message
