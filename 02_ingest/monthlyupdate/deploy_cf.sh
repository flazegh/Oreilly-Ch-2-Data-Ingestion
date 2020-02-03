#!/bin/bash
URL=ingest_flights_$(openssl rand -base64 48 | tr -d /=+ | cut -c -32)
URL=ingest_flights_6gSSzRcgC3low8h1rhdZMuReYO8OI9fn     
echo $URL

gcloud functions deploy $URL --entry-point=ingest_flights --runtime python37 --trigger-http --timeout 480s --memory=2048MB --allow-unauthenticated
