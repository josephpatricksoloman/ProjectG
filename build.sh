#!/bin/bash
# build.sh
docker-compose build
docker tag joseph josephpatricksoloman/development:latest
docker push josephpatricksoloman/development:latest
# testing webhook