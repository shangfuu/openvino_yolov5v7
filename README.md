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

## Benchmark (fps)

|              | FP32 CPU | FP16 CPU | INT8 CPU | FP32 GPU | FP16 GPU | INT8 GPU |
| :----------- | :------- | :------- | :------- | :------- | :------- | :------- |
| YOLOv7       | 3.14     | 3.66     | 10.05    | 4.09     | 10.43    | 20.73    |
| YOLOv5m NNCF | 6.50     | 6.89     | 19.24    | 12.69    | 28.29    | 41.90    |
| YOLOv5m POT  | 6.60     | 5.92     | 21.98    | 12.27    | 24.06    | 41.07    |


## COCO val 2017 mAP

|                   | Class | Images | Labels | Precision | Recall | mAP50 | mAP   |
| :---------------- | :---- | :----- | :----- | :-------- | :----- | :---- | :---- |
| YOLOv7 NNCF FP32  | all   | 5000   | 36335  | 0.718     | 0.638  | 0.689 | 0.495 |
| YOLOv7 NNCF INT8  | all   | 5000   | 36335  | 0.715     | 0.639  | 0.688 | 0.491 |
| YOLOv5m NNCF FP32 | all   | 5000   | 36335  | 0.714     | 0.580  | 0.633 | 0.448 |
| YOLOv5m NNCF INT8 | all   | 5000   | 36335  | 0.714     | 0.575  | 0.631 | 0.443 |
| YOLOv5m POT FP32  | all   | 5000   | -      | -         | -      | 0.632 | 0.447 |
| YOLOv5m POT INT8  | all   | 5000   | -      | -         | -      | 0.630 | 0.441 |

## COCO 128 train 2017 mAP
Download from "https://ultralytics.com/assets/coco128.zip"

|                   | Class | Images | Labels | Precision | Recall | mAP50 | mAP   |
| :---------------- | :---- | :----- | :----- | :-------- | :----- | :---- | :---- |
| YOLOv7 NNCF FP32  | all   | 128    | 929    | 0.821     | 0.703  | 0.812 | 0.612 |
| YOLOv7 NNCF INT8  | all   | 128    | 929    | 0.794     | 0.730  | 0.811 | 0.606 |
| YOLOv5m NNCF FP32 | all   | 128    | 929    | 0.726     | 0.687  | 0.769 | 0.554 |
| YOLOv5m NNCF INT8 | all   | 128    | 929    | 0.743     | 0.677  | 0.767 | 0.545 |
| YOLOv5m POT FP32  | all   | 128    | 929    | -         | -      | 0.768 | 0.554 |
| YOLOv5m POT INT8  | all   | 128    | 929    | -         | -      | 0.767 | 0.545 |
