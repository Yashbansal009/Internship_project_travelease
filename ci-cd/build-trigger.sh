#!/bin/bash
# Script to trigger Jenkins build on commit/PR

JENKINS_URL="http://ec2-3-110-194-212.ap-south-1.compute.amazonaws.com:8080"
JOB_NAME="Travel-ease"
USER="admin"
API_TOKEN="11769871cc76bdbd6b674643cfdc5b90fc"

curl -X POST "$JENKINS_URL/job/$JOB_NAME/build" --user "$USER:$API_TOKEN"
