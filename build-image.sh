#!/bin/bash

docker build -t cgit:temp ./docker

read -p "Enter version [0.3]: " version
version=${version:-0.3}

slim build --continue-after 1 --http-probe=false --include-path-file=./docker/keep-paths-list --target cgit:temp --tag truebad0ur/cgit:"$version"-`arch`

docker push truebad0ur/cgit:"$version"-`arch`
