#!/bin/bash

docker build -t cgit ./docker

slim build --continue-after 1 --http-probe=false --include-path-file=./docker/keep-paths-list --target cgit:latest --tag truebad0ur/cgit:0.1-`arch`

docker push truebad0ur/cgit:0.1-`arch`
