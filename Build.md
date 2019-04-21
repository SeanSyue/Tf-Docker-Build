# Guide for building `Tensorflow` with `Docker`

## Create the directory to store built wheel file
```bash
mkdir out
```

## Prepare the `docker` image

### CPU build
Build image locally by yourself (**RECOMMENDED**):
```bash
docker build -t tf-build:cpu .
```

### GPU build
For GPU build, change the `TAG` argument in the `Dockerfile` to `"nightly-devel-gpu-py3"`, then run the command: 
```bash
docker build tf-build:gpu
```

Or you can specify tags parameters during docker image building:
```bash
docker build --build-arg TAG="nightly-devel-gpu-py3" tf-build:gpu
```

### Build for other python distributions
Optionally, you can change the defualt `python` version to your desired one by modifying the `PY_VER` argument in the `Dockerfile`, or, of course, you can pass the argument when running the `docker build` command. 


### Pull pre-built image
If you wanna pull the pre-built image, you can do:
```bash
docker pull sean962081468/tf-build:1.13.1-cpu-py3.7.3
```

## Initiate the `docker` container environment
```bash
# run the container with volume and parameter assigned
docker run -it -v $pwd/out:/mnt -e HOST_PERMS="$(id -u):$(id -g)" --name <container_name> tf-build:<tag>
```

## Build `tensorflow` inside the container

The whole building procedure as below:

1. Configure the build—this prompts the user to answer build configuration questions.
2. Build the tool used to create the pip package.
3. Run the tool to create the pip package.
4. Adjust the ownership permissions of the file for outside the container.

```bash
./configure  # answer prompts or use defaults
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /mnt  # create package
chown $HOST_PERMS /mnt/tensorflow-<tf-version>-cp37-cp37m-linux_x86_64.whl
```

### Information on the prompt questions
The first question is to locate the `python` location based on your choice, for example, since `python3.7` is the default choice in this container, you can specify `python3.7` location during the configure session. Related sample configure:
```bash
Please specify the location of python. [Default is /usr/bin/python]: /usr/bin/python3.7

Found possible Python library paths:
  /usr/local/lib/python3.7/dist-packages
  /usr/lib/python3.7/dist-packages
Please input the desired Python library path to use.  Default is [/usr/lib/python3.7/dist-packages]
# Press [Enter]
......
```

## Install `tensorflow` for the host
Till now, you should find out a `tensorflow` wheel stored in the `out` folder. You may install `tensorflow` for your host machine by `pip install tensorflow-<tf-version>-cp37-cp37m-linux_x86_64.whl`. 
If the wheel file doesn't exists, check out [the Trouble shooting](README.md#Wheel-file-not-found-in-the-`out`-folder). 