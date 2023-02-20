# OpenVINO Notebooks

```bash=
docker built -t openvino_notebooks .
docker build -t openvino:2022.3 .
```

```bash=
docker run -it -p 8887:8887 --shm-size 8G --name yolo openvino_notebooks
```

```bash=
docker run --device /dev/dri:/dev/dri \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
            --group-add="$(stat -c "%g" /dev/dri/render*)" \
            -it -p 8888:8888 --shm-size 8G -v $(pwd):/opt/app-root/ \ 
            --name yolo openvino:2022.3
```

```bash=
docker start yolo -ai
```


# OPENCL_GROUP=$(getent group 109 | cut -d: -f1)