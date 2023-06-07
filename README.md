# veggy — A Smart and Fun Solution to Encourage Children to Eat Vegetables | iOS App Dev, Python, Azure Blob Storage, Photo Recognition, OpenCV, Threads 

veggy is a project that aims to encourage children to eat vegetables regularly by providing an entertaining and interactive eating experience. It consists of a mobile application and an interactive food tray that work together to measure the weight of vegetables, provide feedback and rewards, and optimize the recommendation system based on children’s preferences. 

<kbd><img src="https://github.com/open-minded13/2023_veggy/assets/52095472/a6e42880-8750-4a06-a369-956254653c12.png" height="500px"/></kbd> 

## Hardware 

The hardware part of veggy includes: 

- An interactive food tray with a load cell, a camera, a servo motor that carries a toy, and a push button. 
- A Raspberry Pi that connects to the food tray and sends data to the cloud. 
- A Bluetooth speaker that plays music and sound effects during and after eating. 

<kbd><img src="https://github.com/open-minded13/2023_veggy/assets/52095472/ddf5aad0-7dae-467d-88df-d8f60abf2e16.png" height="500px"/></kbd> 

The hardware components are enclosed in a 3D-printed prototype of a spinning rabbit on top of the food tray. The load cell measures the weight of the vegetables before and after eating, the camera takes pictures of the food residuals, the servo motor rotates the rabbit according to the task completion, and the push button starts and stops the eating task. The Raspberry Pi code is written in Python. 

The code can be found in the "veggy's main program running on Raspberry Pi" folder. 

## Software 

The software part of veggy includes: 

- A mobile application that communicates with the hardware components and displays real-time data. 
- A cloud service, Azure Blob Storage, stores image and weight data. 
- A machine learning model for vegetable recognition that runs on another cloud service, RunPod GPU Cloud. 
- A vegetable recommendation system that is based on children's intake. 
- A reward system that allows children to earn points for eating vegetables and redeem rewards. 

The mobile application is developed using XCode. It has features such as profile creation, vegetable selection, data visualization, reward redemption, etc. The app code can be found in the "veggy's iOS app" folder. 

<kbd><img src="https://github.com/open-minded13/2023_veggy/assets/52095472/fe5ccba2-bcd2-4eda-b80e-34cfa81d81ab.png" height="500px"/></kbd>

Another part of the software is a Python script that uses FastAPI and Roboflow libraries to create a web service that analyzes images of food residuals and detects the vegetable children left in the bowl. The code can be found in the "veggy's APIs that connect to the ML model for vegetable recognition in the cloud service" folder. 

The web service has two endpoints: `@app.get("/")` and `@app.get("/analyze/v2/{session_uuid}")`.

The `@app.get("/")` endpoint is a simple hello world message that returns a JSON object with a message key and a value of "Hello World."

The `@app.get("/analyze/v2/{session_uuid}")` endpoint is the main functionality of the web service. It takes a session UUID as a parameter and uses it to retrieve an image from Azure Blob Storage. It then uses Roboflow to load a pre-trained model for vegetable recognition and predict the vegetables in the uploaded photo. It returns a JSON object with the prediction results.

The web service connects to the ML model hosted on RunPod GPU Cloud, a platform for deploying and running deep learning models. The Roboflow library provides an easy way to access the model and make predictions using its API.
