
docker build -t openvino:2022.3 .

docker run --device /dev/dri:/dev/dri \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
            --group-add="$(stat -c "%g" /dev/dri/render*)" \
            -it -p 8888:8888 --shm-size 8G -v $(pwd):/opt/app-root/ \
            --name yolo openvino:2022.3