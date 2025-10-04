# Logseq in container

This is a docker tool for running logseq in a container with noVNC support.
With this tool, we can build a logseq API server that can access server local filesystem by map volumes to docker container.

## clone or download this repo

Don't forget to cd to the repo dir.

## build and start the docker image

```bash
docker compose up --build
```

## acess

* VNC: `http://127.0.0.1:12314`
* API Server: `http://127.0.0.1:12315`
  * to access the API Server, you need to set it up using VNC in the logseq setting page first [see manual setup](#manual-setup)

## manual setup

1. It is required that graphs are manually added via the logseq UI create a folder inside the container `/data` and select that as your graph this allows easy syncing of the `./data/logseq_data` directory

2. If you wish to use the [logseq api](https://docs.logseq.com/#/page/local%20http%20server) enable it via the VNC interface

## Thanks

Based on this great project: [docker-novnc](https://github.com/theasp/docker-novnc) !
