# About

Official repo - https://git.zx2c4.com/cgit/about/

# Build

1. `git clone git@github.com:TrueBad0ur/cgit.git`
2. `git submodule update --init --recursive`
3. `cd cgit`
4. `make`
5. `sudo make install`

## Useful files
- everything in /var/www/htdocs/cgit/
- cgit(binary) -> usually renames to cgit.cgi
- cgit.js
- cgit.css
- cgit.png
- favicon.ico
- robots.txt
- filers/* in /usr/local/lib/cgit/filters/

## Useful info

To add description of repo you should add text to .git/description

Copy data to PV:
```bash
k apply -f copier.yml

k cp ./local-repository/ cgit/copier:/var/www/htdocs/cgit/repositories/local-repository
```

### To build for multiple arch's:
```bash
export DOCKER_CLI_EXPERIMENTAL=enabled
docker buildx create --use --name multi-arch-builder
docker buildx build --platform=linux/amd64,linux/arm64 -t cgit ./docker/
```
If resolv docker registry with buildx fails:
```bash
docker buildx rm
```

## Testing

Build: `docker build -t cgit ./docker`

Stop the container: `docker ps -a | grep cgit | awk {'print $1'} | xargs docker stop`

Run: `docker run -v ./docker/repositories/:/var/www/htdocs/cgit/repositories/ --rm --network host --name cgit cgit`

Slim image `slim build --continue-after 1 --http-probe=false --include-path-file=./docker/keep-paths-list --target cgit:latest`

# Useful links

https://git.zx2c4.com/cgit/tree/Makefile

https://wiki.archlinux.org/title/Cgit

https://github.com/TrueBad0ur/alpine-cgit/tree/master/root/scripts

https://woahbase.online/images/alpine-cgit/
