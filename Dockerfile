ARG TAG="nightly-devel"
FROM tensorflow/tensorflow:$TAG
VOLUME /mnt
ARG PY_VER="3.7"

# Copy necessary files for installing `bazel` and `pip`
WORKDIR /home
COPY . .

# Remove out-dated `bazel` and install the up-to-date `bazel` release
RUN find / ! -path "/tensorflow/*" ! -path "/usr/local/lib/python2.7/*" -iname "*bazel*" | xargs rm -rf && \
  chmod +x bazel-0.24.1-installer-linux-x86_64.sh && \
 ./bazel-0.24.1-installer-linux-x86_64.sh 

# Install `python` and python dependencies
RUN add-apt-repository ppa:deadsnakes/ppa -y && \
  apt-get update && \
  apt-get install python$PY_VER python$PY_VER-dev -y && \
  wget https://bootstrap.pypa.io/get-pip.py && \
  python$PY_VER get-pip.py && \
  python$PY_VER -m pip install numpy keras_applications keras_preprocessing h5py

# Prepare for `tensorflow` building process
WORKDIR /tensorflow
RUN git pull
CMD ["bash"]