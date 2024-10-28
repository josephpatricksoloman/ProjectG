#!/bin/bash
# build.sh
docker-compose build
docker tag josephpatricksoloman:josephpatricksoloman/development:latest
docker push josephpatricksoloman/development:latest
