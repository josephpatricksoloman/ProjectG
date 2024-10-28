#!/bin/bash
# build.sh

# Build the Docker image using docker-compose
docker-compose build

# Tag the built image correctly
docker tag development_react-app:latest josephpatricksoloman/development:latest

# Push the image to Docker Hub
docker push josephpatricksoloman/development:latest
