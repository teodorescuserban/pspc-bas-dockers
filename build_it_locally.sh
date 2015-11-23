#!/bin/bash

for image in base base-mysql base-python mysql api; do

    docker build -t docker.io/teodorescuserban/pspc-$image:latest $image/

done
