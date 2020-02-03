#!/bin/bash


## back fill all data 
for year in 2016 2017 2018 2019 2020; do
    for month in `seq -w 1 12`; do
       #echo $year $month 
       #sleep 5
       echo "{\"year\":\"${year}\",\"month\":\"${month}\",\"bucket\":\"fiery-bit-266210-ds40\", \"token\":\"0Gdv7YywE0NEUVdtmNHv4a7Ffk6MpEf1\"}" > "/tmp/message_${year}_${month}" && \
       curl -X POST "https://us-central1-fiery-bit-266210.cloudfunctions.net/ingest_flights_6gSSzRcgC3low8h1rhdZMuReYO8OI9fn" -H "Content-Type:application/json" --data-binary @"/tmp/message_${year}_${month}" 
    done
done

