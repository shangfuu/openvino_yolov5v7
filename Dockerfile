FROM ubuntu:20.04

ENV JUPYTER_ENABLE_LAB="true" \
  ENABLE_MICROPIPENV="1" \
  UPGRADE_PIP_TO_LATEST="1" \
  WEB_CONCURRENCY="1" \
  THOTH_ADVISE="0" \
  THOTH_ERROR_FALLBACK="1" \
  THOTH_DRY_RUN="1" \
  THAMOS_DEBUG="0" \
  THAMOS_VERBOSE="1" \
  THOTH_PROVENANCE_CHECK="0"

USER root

# Install some basic utilities
RUN apt-get update 
RUN apt-get install -y \
    git \
    zip \
    sudo \
    libx11-6 \
    build-essential \
    ca-certificates \
    wget \
    curl \
    tmux \
    htop \
    nano \
    vim

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y --no-install-recommends

# ####################################################################################
# Create a non-root user named openvino
RUN adduser --disabled-password --gecos '' --shell /bin/bash openvino
RUN echo "openvino ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user
USER openvino

WORKDIR /home/openvino
# Custom .vimrc
RUN curl -o .vimrc https://gist.githubusercontent.com/shungfu/2e2cf0ad400306c8ca0623b850560dc1/raw/6764bd66ac818f7d07eaedfb997b919e132aa963/.vimrc
# Custom .bashrc
RUN curl -o .bashrc https://gist.githubusercontent.com/shungfu/abf56b6cfb9232edd5e264a6adda32b8/raw/34c86c3b714ac5b01d98361a001b5c9e980f682f/.bashrc

# Install Miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh \
 && chmod +x ~/Miniconda3-py38_4.9.2-Linux-x86_64.sh\
 && ~/Miniconda3-py38_4.9.2-Linux-x86_64.sh -b -p ~/miniconda \
 && rm ~/Miniconda3-py38_4.9.2-Linux-x86_64.sh
ENV PATH=/home/openvino/miniconda/condabin/:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false
RUN conda init

# Create a Python 3.8 environment openvino
RUN conda create -y --name openvino python=3.8.13 && conda clean -ya
RUN echo "conda activate openvino" >> .bashrc
ENV CONDA_DEFAULT_ENV=openvino
ENV CONDA_PREFIX=/home/openvino/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH

# # ####################################################################################
# # Install OpenVINO 2022.3 and necessary
WORKDIR /opt/

COPY requirements.txt /opt/
RUN pip3 install -r /opt/requirements.txt

USER root
RUN rm /opt/requirements.txt

# Enable intel gpu
# Add package repository
RUN apt-get install -y \
    intel-opencl-icd \
    pciutils \
    git-all \
    software-properties-common \
    gpg-agent

# ####################################################################################
WORKDIR /opt/app-root/
# COPY notebooks/ /opt/app-root/notebooks
# RUN chown -R openvino:0 /opt/app-root/notebooks

EXPOSE 8888

USER openvino
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root"]
