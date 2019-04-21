# Tensorflow Docker Building Setup
A helper for setting up up-to-date `Tensorflow` building environment with `Docker`. Provided with both CPU and GPU support. 

## Notification
1. This repository was tested under:
   * `tensorflow` version: 1.13.1
   * `python` version: 3.7.3
   * `bazel` version: 0.24.1
2. To get the whole picture of building `tensorflow`, check the [official site](https://www.tensorflow.org/install/source). 

## Pre-build image available
**It's better approach to build up-to-date images by yourself**, by using the `Dockerfile` inside this repository, though, there is pre-built image available in the `docker hub`, which may slightly shorten the build time. 

Check [here](Build.md#Pull-pre-built-image) to learn more. 

### Overall build process
1. Make folder to store built wheel
2. Pull pre-built image, or build the `docker` image locally
3. Run the `docker` container
4. Build `tensorflow` inside the container
5. Install `tensorflow` for the host machine

### Detailed build process
Check [here](Build.md) for detailed process!

## Trouble shooting

### Wheel file not found in the `out` folder
You need to copy file from container to host, use `docker cp` command:
```bash
docker cp <containerId>:/file/path/within/container /host/path/target
```