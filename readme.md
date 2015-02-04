# docker-sabnzbd

This is a docker container running sabnzbd.

## Details

This is an ubuntu container; the multiverse sources will be added to the ubuntu repositories. From there, sabnzbdplus will be downloaded from its official package and installed.

`sabnzbdplus` will be run by supervisor, to restart the process if it crashes.


## Building

1. Clone this repo
2. inside the repo directory, build the image

	`docker build -t <name> .`


## Linking

It is suggested you map a volume to this container to your host file system to transfer files to. The dockerfile recommends `/data` within the container.

For example:

	`docker run 13ebd -p 8080:8080 -v ~/files:/data`
	
If our build produced an image id of `13ebd`, this command executes the image `13ebd`, maps port `8080` to your localhost and maps the `/data` folder inside the container to `~/files` on your host.

Supervisor kicks off `sabnzbdplus` and forces `0.0.0.0:8080`, so the internal port will always be 8080. This is needed because the default config binds to localhost and must be forced to use 0.0.0.0 otherwise the setup wizard wouldn't work through the container.

## Copying an existing config

You can copy your existing config details into the running container.

1. First, get the container id of the running container via `docker ps`
2. On your running installation, locate `sabnzb.ini`. This is usually in `~/.sabnzbd/`
3. Copy that file into the container, overwriting the existing ini file.

	`docker exec -i c479d /bin/bash -c 'cat > /root/.sabnzbd/sabnzbd.ini' < sabnzbd.ini`
	
	For example, if `c479d` was your container id.
	
4. Restart sab. You can just restart the container
