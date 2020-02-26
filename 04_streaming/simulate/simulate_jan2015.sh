#!/bin/bash
python3 simulate.py --project $(gcloud config get-value project) --startTime '2015-01-01 00:00:00 UTC' --endTime '2015-01-06 00:00:00 UTC' --speedFactor 480
