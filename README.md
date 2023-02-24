# OpenVINO Notebooks

>OS: Ubuntu 20.04.5 LTS\
OpenVINO: 2022.3\
Python: 3.8.13\
CPU: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz\
Memory: 16 GB\


## Installation Guide
We provide two ways to build the environment.

### 1. Build Docker Image and Container

There are two ways to build and run the software:

1. Run the setup.sh script by executing the following command in the terminal:
```bash=
bash setup.sh
```

2. Alternatively, you can build and run the software using command line. To do this, first build the Docker image by executing the following command:
```bash=
docker build -t openvino:2022.3 .
```
```bash=
docker run --device /dev/dri:/dev/dri \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
            --group-add="$(stat -c "%g" /dev/dri/render*)" \
            -it -p 8888:8888 --shm-size 8G -v $(pwd):/opt/app-root/ \ 
            --name yolo openvino:2022.3
```

This command will start a Docker container named "yolo" and configure it to use the necessary hardware and software resources. Once the container is running, you can interact with it using the specified ports and volumes.

Once the image has been built, you can run it using the following command:

```bash=
docker start yolo -ai
```

This command will start the existing container named "yolo" and attach to it interactively.

### 2. Using Local Machine

```bash=
pip install -r requirements.txt
```

## Getting Started

- The [compare_YOLOv7_vs_YOLOv5.ipynb](./notebooks/yolov5v7/compare_YOLOv7_vs_YOLOv5.ipynb) script is used to compare the mAP (mean Average Precision) of YOLOv5 and YOLOv7 models using source code.
- The [yolov5-nncf-optimization.ipynb](./notebooks/yolov5v7/yolov5-nncf-optimization.ipynb) script is used to optimize the YOLOv5 model using NNCF(Neural Network Compression Framework) quantization to convert it to OpenVINO format in FP32, FP16, and INT8 precision modes. This script also checks the evaluation metrics and benchmark performance to ensure that the optimized model maintains accuracy and performance.
- The [yolov5-pot-optimization.ipynb](./notebooks/yolov5v7/yolov5-pot-optimization.ipynb) script is used to optimize the YOLOv5 model using POT(Post-training Optimization Tool) quantization to convert it to OpenVINO format in FP32, FP16, and INT8 precision modes. This script also checks the evaluation metrics and benchmark performance to ensure that the optimized model maintains accuracy and performance.
- The [yolov7-optimization.ipynb](./notebooks/yolov5v7/yolov7-optimization.ipynb) notebook is cloned from the [226-yolov7-optimization.ipynb](https://github.com/openvinotoolkit/openvino_notebooks/tree/main/notebooks/226-yolov7-optimization) repository in the [openvino_notebooks](https://github.com/openvinotoolkit/openvino_notebooks) GitHub.

## Benchmark (fps)

|              | FP32 CPU | FP16 CPU | INT8 CPU | FP32 GPU | FP16 GPU | INT8 GPU |
| :----------- | :------- | :------- | :------- | :------- | :------- | :------- |
| YOLOv7 NNCF  | 3.14     | 3.66     | 10.05    | 4.09     | 10.43    | 20.73    |
| YOLOv5m NNCF | 6.50     | 6.89     | 19.24    | 12.69    | 28.29    | 41.90    |
| YOLOv5m POT  | 6.60     | 5.92     | 21.98    | 12.27    | 24.06    | 41.07    |


## COCO val 2017 mAP

|                   | Size | Class | Images | Labels | Precision | Recall | mAP50 | mAP   |
| :---------------- | :--- | :---- | :----- | :----- | :-------- | :----- | :---- | :---- |
| YOLOv7 NNCF FP32  | 640  | all   | 5000   | 36335  | 0.718     | 0.638  | 0.689 | 0.495 |
| YOLOv7 NNCF FP16  | 640  | all   | 5000   | 36335  | 0.725     | 0.634  | 0.689 | 0.493 |
| YOLOv7 NNCF INT8  | 640  | all   | 5000   | 36335  | 0.715     | 0.639  | 0.688 | 0.491 |
| YOLOv5m NNCF FP32 | 640  | all   | 5000   | 36335  | 0.714     | 0.580  | 0.633 | 0.448 |
| YOLOv5m NNCF FP16 | 640  | all   | 5000   | 36335  | 0.714     | 0.580  | 0.633 | 0.448 |
| YOLOv5m NNCF INT8 | 640  | all   | 5000   | 36335  | 0.714     | 0.575  | 0.631 | 0.443 |
| YOLOv5m POT FP32  | 640  | all   | 5000   | 36335  | -         | -      | 0.632 | 0.447 |
| YOLOv5m POT FP16  | 640  | all   | 5000   | 36335  | -         | -      | 0.632 | 0.447 |
| YOLOv5m POT INT8  | 640  | all   | 5000   | 36335  | -         | -      | 0.630 | 0.441 |

## COCO 128 train 2017 mAP
Download from "https://ultralytics.com/assets/coco128.zip"

|                   | Size | Class | Images | Labels | Precision | Recall | mAP50 | mAP   |
| :---------------- | :--- | :---- | :----- | :----- | :-------- | :----- | :---- | :---- |
| YOLOv7 NNCF FP32  | 640  | all   | 128    | 929    | 0.821     | 0.703  | 0.812 | 0.612 |
| YOLOv7 NNCF FP16  | 640  | all   | 128    | 929    | 0.822     | 0.703  | 0.812 | 0.609 |
| YOLOv7 NNCF INT8  | 640  | all   | 128    | 929    | 0.794     | 0.730  | 0.811 | 0.606 |
| YOLOv5m NNCF FP32 | 640  | all   | 128    | 929    | 0.726     | 0.687  | 0.769 | 0.554 |
| YOLOv5m NNCF FP16 | 640  | all   | 128    | 929    | 0.726     | 0.686  | 0.769 | 0.554 |
| YOLOv5m NNCF INT8 | 640  | all   | 128    | 929    | 0.743     | 0.677  | 0.767 | 0.545 |
| YOLOv5m POT FP32  | 640  | all   | 128    | 929    | -         | -      | 0.768 | 0.554 |
| YOLOv5m POT FP16  | 640  | all   | 128    | 929    | -         | -      | 0.768 | 0.553 |
| YOLOv5m POT INT8  | 640  | all   | 128    | 929    | -         | -      | 0.767 | 0.545 |
