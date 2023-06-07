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

The code can be found in the "[**veggy's main program running on Raspberry Pi**](https://github.com/open-minded13/2023_veggy/tree/main/veggy's%20main%20program%20running%20on%20Raspberry%20Pi/veggy)" folder. 

## Software 

The software part of veggy includes: 

- A mobile application that communicates with the hardware components and displays real-time data. 
- A cloud service, Azure Blob Storage, stores image and weight data. 
- A machine learning model for vegetable recognition that runs on another cloud service, RunPod GPU Cloud. 
- A vegetable recommendation system that is based on children's intake. 
- A reward system that allows children to earn points for eating vegetables and redeem rewards. 

The mobile application is developed using XCode. It has features such as profile creation, vegetable selection, data visualization, reward redemption, etc. The app code can be found in the "[**veggy's iOS app**](https://github.com/open-minded13/2023_veggy/tree/main/veggy's%20iOS%20app)" folder. 

<kbd><img src="https://github.com/open-minded13/2023_veggy/assets/52095472/fe5ccba2-bcd2-4eda-b80e-34cfa81d81ab.png" height="500px"/></kbd>

Another part of the software is a Python script that uses FastAPI and Roboflow libraries to create a web service that analyzes images of food residuals and detects the vegetable children left in the bowl. The code can be found in the "[**veggy's APIs that connect to the ML model for vegetable recognition in the cloud service**](https://github.com/open-minded13/2023_veggy/tree/main/veggy's%20APIs%20that%20connect%20to%20the%20ML%20model%20for%20vegetable%20recognition%20in%20the%20cloud%20service)" folder. 

The web service has two endpoints: `@app.get("/")` and `@app.get("/analyze/v2/{session_uuid}")`.

The `@app.get("/")` endpoint is a simple hello world message that returns a JSON object with a message key and a value of "Hello World."

The `@app.get("/analyze/v2/{session_uuid}")` endpoint is the main functionality of the web service. It takes a session UUID as a parameter and uses it to retrieve an image from Azure Blob Storage. It then uses Roboflow to load a pre-trained model for vegetable recognition and predict the vegetables in the uploaded photo. It returns a JSON object with the prediction results.

The web service connects to the ML model hosted on RunPod GPU Cloud, a platform for deploying and running deep learning models. The Roboflow library provides an easy way to access the model and make predictions using its API.

## Video Demos

You can watch a video demo of veggy here:

- **Hardware Demo Video:** In the video, a yard is substituted for vegetables, showing how the device reacts when a child successfully eats the vegetable in the bowl.

  [![hardware demo video](https://github.com/open-minded13/2023_veggy/assets/52095472/46dfc0b0-67f4-4ada-b462-65a2efd23ad5)](https://drive.google.com/file/d/1RSlcn4H1R8PCYDWtMCHXxhNOMtjj_m8e/preview "hardware demo video.mp4")

- **Software Demo Video:** The video shows that when a child leaves leftovers (that is, the challenge fails), the mobile app will pop up a prompt box and display the type and weight of the remaining vegetables.

  [![software demo video](https://github.com/open-minded13/2023_veggy/assets/52095472/05ec26cf-b3ca-4bb1-9d73-20f29b178d5a)](https://drive.google.com/file/d/1pLkUiI7FWuXPBnKOSgjVUg4e6fhkSjCZ/preview "software demo video.mp4")
  
## Reflection

This project was a valuable learning experience for us. We applied our skills from classroom sessions, such as sending data to Azure, fetching data from the app, implementing design thinking concepts, etc. We also encountered some difficulties, such as sensor instability, Bluetooth connection, prototype design, etc. We solved them by troubleshooting and testing our solutions.

If we had another chance to improve our project, we would focus more on the user experience from the start. We realized we gave too much attention to the technical aspects, resulting in a solution more appealing to parents' supervision than children's dining experience. We should have added more fun and interactive elements for children in the future.

## Team Members & Acknowledgments

While we assist each other in the product development cycle, for each part of the project, there are key contributors:

- [**Mia Wang**](https://www.linkedin.com/in/yunqi-mia-wang-916912173/) and [**I (Chia-Wei Chang)**](https://www.linkedin.com/in/chiaweic1/): Key contributors for product iterations, sensors & circuit configurations, Azure cloud service setup, and Python programming on the Raspberry Pi.
- [**Eureka Du**](https://www.linkedin.com/in/yingke-derrick-ding/): As the interface designer of iOS software and the mechanism of the reward system.
- [**Derrick Ding**](https://www.linkedin.com/in/yingke-derrick-ding/): As a key contributor to the iOS software and cloud configuration of ML modules.

## Appendix

- [**Pitch Deck**](https://docs.google.com/presentation/d/1FgAJaAH5Dx1LO6J0nQpGfOZaeG5Etb_jXpKR93Td52I/edit?usp=sharing): You can also view the presentation pitch deck to understand more about our product. 
