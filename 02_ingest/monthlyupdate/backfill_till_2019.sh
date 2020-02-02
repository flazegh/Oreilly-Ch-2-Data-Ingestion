#!/bin/bash


## back fill all data 
for year in 2016 2017 2018 2019; do
    for month in `seq -w 1 12`; do
       #echo $year $month 
       echo "{\"year\":\"${year}\",\"month\":\"${month}\",\"bucket\":\"fiery-bit-266210-ds40\", \"token\":\"0Gdv7YywE0NEUVdtmNHv4a7Ffk6MpEf1\"}" > "/tmp/message_${year}_${month}" && \
       curl -X POST "https://us-central1-fiery-bit-266210.cloudfunctions.net/ingest_flights_1WERq5RTay7q0t0yrey6vNMDm366yNYP" -H "Content-Type:application/json" --data-binary @"/tmp/message_${year}_${month}" &
    done
done

