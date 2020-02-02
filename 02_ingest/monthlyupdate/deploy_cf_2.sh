#!/bin/bash
cp main.py.bak main.py

URL=ingest_flights_$(openssl rand -base64 48 | tr -d /=+ | cut -c -32)
echo $URL

sed -i "s/def ingest_flights(request):/def $URL(request):/g" main.py
gcloud functions deploy $URL --runtime python37 --trigger-http --timeout 480s
