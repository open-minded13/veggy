import urllib.request
import yaml
from fastapi import FastAPI
from roboflow import Roboflow

app = FastAPI()

roboflow_api_key = None

with open("configs.yaml", "r") as stream:
    try:
        roboflow_api_key = yaml.safe_load(stream)["roboflow_api_key"]

    except yaml.YAMLError as exc:
        print(exc)

rf = Roboflow(api_key=roboflow_api_key)


@app.get("/")
async def root():
    return {"message": "Hello World"}

# @app.get("/analyze/{session_uuid}")
# async def analyze(session_uuid):
#     image_url = "https://veggyimage.blob.core.windows.net/image/" + session_uuid + "-photo_after_eating.png"
#     image_path = "./input-images/" + session_uuid + "-input-analyze.png"

#     urllib.request.urlretrieve(image_url, image_path)

#     model_types = "yolov5l"
#     output_path = "./output-images/" + session_uuid + "-analyzed.png"

#     output_path, output_type, result_list = get_prediction(
#         image_path,
#         output_path,
#         model_name=model_types
#     )

#     return {"result": result_list}

@app.get("/analyze/v2/{session_uuid}")
async def analyze_v2(session_uuid: str):
    project = rf.workspace().project("vegetable-detector")
    model = project.version(2).model

    image_url = "https://veggyimage.blob.core.windows.net/image/" + session_uuid + "-photo_after_eating.png"
    image_path = "./input-images/" + session_uuid + "-input-analyze.png"

    urllib.request.urlretrieve(image_url, image_path)

    # infer on a local image
    return model.predict(image_path, confidence=1, overlap=30).json()

    # visualize your prediction
    # model.predict("your_image.jpg", confidence=40, overlap=30).save("prediction.jpg")

    # infer on an image hosted elsewhere
    # print(model.predict("URL_OF_YOUR_IMAGE", hosted=True, confidence=40, overlap=30).json())
