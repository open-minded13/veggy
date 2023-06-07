# Team: veggy
# Team Members: Mia Wang, Eureka Du, Derrick Ding, Chia-Wei Chang
# Department: Master of Science in Technology Innovation, University of Washington
# Contribution:
# - Code Concepts and Logic:  Chia-Wei Chang, Mia Wang
# - Debugging and Refinement: Powered by ChatGPT

# Importing necessary libraries.
import RPi.GPIO as GPIO
from picamera import PiCamera
from hx711 import HX711
import requests
import io
import time
from azure.storage.blob import BlobServiceClient, ContentSettings
import threading
import os
import pygame
import uuid
import json
import subprocess

# GPIO Setup for the start/stop button.
start_stop_button = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(start_stop_button, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# GPIO Setup for the servomotor.
servo_pin = 14
GPIO.setup(servo_pin, GPIO.OUT)
pwm = GPIO.PWM(servo_pin, 50)  # 50 Hz frequency
pwm.start(0)  # Start the PWM with a duty cycle of 0
weight_data = {"weight": 0, "is_eating": False}

# Initialize the scale object.
hx = HX711(dout=27, pd_sck=17, gain=128)

# Initialize the camera object.
camera = PiCamera()

# Global variables.
is_eating = False

# Calibrate the HX711 to an offset and scale value in grams.
OFFSET = 0.0
SCALE = -919.77
# The threshold weight indicating that the scale is empty.
ZERO_OFFSET_FOR_CAllIBRATION = 0.5
ZERO_OFFSET = 5

# Variables for Azure Blob Storage.
connection_string = "DefaultEndpointsProtocol=https;AccountName=veggyimage;AccountKey=zrbr4VgcR1d01ZkJoxUjvZapUrDxFbB44lWYxdYtXpLQK8PYIDPidL70t9lpbb6jFgfFaa+Vslmt+AStVdvudA==;EndpointSuffix=core.windows.net"
image_container_name = "image"
string_container_name = "weight"


def calibrate_to_grams():
    global OFFSET
    print(
        "The scale will be reset in 3 seconds! Please ensure that the scale top is empty.\n"
    )
    upload_instruction_to_azure("start_calibrate")

    time.sleep(3)
    hx.set_offset(OFFSET)
    hx.set_scale(SCALE)
    OFFSET = hx.read_average()
    hx.set_offset(OFFSET)
    while abs(hx.get_grams()) > ZERO_OFFSET_FOR_CAllIBRATION:
        OFFSET = hx.read_average()

        hx.set_offset(OFFSET)
    print("The scale has been calibrated to grams.\n")


def measure_item_weight(session_uuid):
    # Main high-precision weighing procedures.
    global connection_string
    global string_container_name
    global is_eating
    if is_eating:
        print("Please put the item on the scale and press the Start/Stop button.\n")
        upload_instruction_to_azure("start_weighing")
        while True:
            if not GPIO.input(start_stop_button):
                print("Weighing, please wait ...\n")
                break
            else:
                time.sleep(0.1)
    time.sleep(5)
    weight = hx.get_grams()
    int_weight = int(round(weight))
    if int_weight < 0:
        int_weight = 0
    print(f"Weight on the scale: {int_weight} gram(s)\n")

    # Upload the weighing data to the Azure cloud.
    weight_data["weight"] = int_weight
    if is_eating == True:
        weight_data["is_eating"] = True
        weight_data["session_uuid"] = str(session_uuid)
        object_name = str(session_uuid) + "-start_weight"
    else:
        weight_data["is_eating"] = False
        weight_data["session_uuid"] = str(session_uuid)
        object_name = str(session_uuid) + "-finish_weight"
    print("Uploading data to Azure:", weight_data, "\n")
    upload_string_to_azure(
        json.dumps(weight_data), connection_string, string_container_name, object_name
    )
    print("Uploaded successfully!\n")

    return int_weight


def take_a_photo(session_uuid):
    output_folder = "/home/veggy/Desktop/Milestone_3/veggy/photos/"
    file_name = str(session_uuid) + "-photo_after_eating.png"
    file = output_folder + file_name
    camera.capture(file)
    camera.close()
    global connection_string
    global image_container_name
    upload_image_to_azure(file, connection_string, image_container_name, file_name)
    time.sleep(1)


def upload_image_to_azure(image_path, connection_string, container_name, object_name):
    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    container_client = blob_service_client.get_container_client(container_name)
    blob_client = container_client.get_blob_client(object_name)
    with open(image_path, "rb") as image_file:
        blob_client.upload_blob(image_file)


def upload_string_to_azure(content, connection_string, container_name, object_name):
    cnt_settings = ContentSettings(content_type="application/json")
    blob_service_client = BlobServiceClient.from_connection_string(connection_string)
    container_client = blob_service_client.get_container_client(container_name)
    blob_client = container_client.get_blob_client(object_name)
    with io.BytesIO(content.encode("utf-8")) as stream:
        blob_client.upload_blob(stream, overwrite=True, content_settings=cnt_settings)


def upload_latest_session_uuid_to_azure(session_uuid):
    session_info = {
        "latest_session_uuid": str(session_uuid),
    }
    upload_string_to_azure(
        content=json.dumps(session_info),
        connection_string=connection_string,
        container_name="session",
        object_name="latest-session",
    )


def upload_instruction_to_azure(name):
    instruction_info = {
        "current_instruction": name,
    }
    upload_string_to_azure(
        content=json.dumps(instruction_info),
        connection_string=connection_string,
        container_name="instruction",
        object_name=str(session_uuid) + "-current_instruction",
    )


def clean_and_exit():
    print("Cleaning up...\n")
    GPIO.cleanup()
    print("Bye!\n")
    quit()


def set_servo_motor_angle(angle):
    duty = angle / 18 + 2
    GPIO.output(servo_pin, True)
    pwm.ChangeDutyCycle(duty)
    time.sleep(0.4)
    GPIO.output(servo_pin, False)
    pwm.ChangeDutyCycle(0)


def run_servo_motor(int_weight):
    # Allow the motor to rotate two revolutions and return to its original position.
    if abs(int_weight) < ZERO_OFFSET:
        print(
            "Now the servo motor is rotating | Weight:",
            int_weight,
            "\n",
        )
        for i in range(3):
            set_servo_motor_angle(0)
            set_servo_motor_angle(90)
            set_servo_motor_angle(180)
        pwm.stop()


def play_background_music():
    # Initialize the pygame mixer.
    pygame.mixer.init()
    background_music_path = (
        "/home/veggy/Desktop/Milestone_3/veggy/songs/BGM_while_eating.mp3"
    )
    pygame.mixer.music.load(background_music_path)

    # Set the volume to 70%, a float value between 0.0 and 1.0.
    pygame.mixer.music.set_volume(1)
    pygame.mixer.music.play()
    print(
        "Now Playing: BGM_while_eating.mp3 | Volume: ",
        pygame.mixer.music.get_volume(),
        "\n",
    )

    # Wait for the song to finish, or the user presses the stop button.
    while pygame.mixer.music.get_busy() and GPIO.input(start_stop_button):
        pass

    if pygame.mixer.music.get_busy():
        pygame.mixer.music.stop()


def play_congrats_music(int_weight):
    if abs(int_weight) < ZERO_OFFSET:
        # Initialize the pygame mixer.
        pygame.mixer.init()
        congrats_music_path = (
            "/home/veggy/Desktop/Milestone_3/veggy/songs/congrats_music.mp3"
        )
        pygame.mixer.music.load(congrats_music_path)

        # Set the volume to 70%, a float value between 0.0 and 1.0.
        pygame.mixer.music.set_volume(0.75)
        pygame.mixer.music.play()
        print(
            "Now Playing: congrats_music.mp3 | Volume:",
            pygame.mixer.music.get_volume(),
            " | Weight:",
            int_weight,
            "\n",
        )

        # Wait for the song to finish, or the user presses the stop button.
        while pygame.mixer.music.get_busy() and GPIO.input(start_stop_button):
            pass

        if pygame.mixer.music.get_busy():
            pygame.mixer.music.stop()


def play_failure_music(int_weight):
    if abs(int_weight) > ZERO_OFFSET:
        # Initialize the pygame mixer.
        pygame.mixer.init()
        failure_music_path = (
            "/home/veggy/Desktop/Milestone_3/veggy/songs/failure_music.mp3"
        )
        pygame.mixer.music.load(failure_music_path)

        # Set the volume to 70%, a float value between 0.0 and 1.0.
        pygame.mixer.music.set_volume(1)
        pygame.mixer.music.play()
        print(
            "Now Playing: failure_music.mp3 | Volume:",
            pygame.mixer.music.get_volume(),
            " | Weight:",
            int_weight,
            "\n",
        )

        # Wait for the song to finish, or the user presses the stop button.
        while pygame.mixer.music.get_busy() and GPIO.input(start_stop_button):
            pass

        if pygame.mixer.music.get_busy():
            pygame.mixer.music.stop()


def play_background_music_after_eating():
    # Initialize the pygame mixer.
    pygame.mixer.init()
    background_music_after_eating_path = (
        "/home/veggy/Desktop/Milestone_3/veggy/songs/BGM_after_eating.mp3"
    )
    pygame.mixer.music.load(background_music_after_eating_path)

    # Set the volume to 70%, a float value between 0.0 and 1.0.
    pygame.mixer.music.set_volume(0.75)
    pygame.mixer.music.play()
    print(
        "Now Playing: BGM_after_eating.mp3 | Volume:",
        pygame.mixer.music.get_volume(),
        " | Weight:",
        int_weight,
        "\n",
    )

    # Wait for the song to finish playing, or the user presses the stop button.
    while pygame.mixer.music.get_busy() and GPIO.input(start_stop_button):
        pass

    if pygame.mixer.music.get_busy():
        pygame.mixer.music.stop()


if __name__ == "__main__":
    if not is_eating:
        session_uuid = uuid.uuid4()
        upload_latest_session_uuid_to_azure(session_uuid)
        print(
            "Session ID for Azure:",
            str(session_uuid),
            "\n\nPress the start/stop button to begin.\n",
        )
        upload_instruction_to_azure("start_process")

    try:
        while True:
            if not is_eating and not GPIO.input(start_stop_button):
                is_eating = True
                calibrate_to_grams()
                measure_item_weight(session_uuid)
                background_music_thread = threading.Thread(
                    target=play_background_music
                )
                background_music_thread.start()

            if is_eating and not GPIO.input(start_stop_button):
                background_music_thread.join()
                is_eating = False
                int_weight = measure_item_weight(session_uuid)
                congrats_music_thread = threading.Thread(
                    target=play_congrats_music(int_weight)
                )
                congrats_music_thread.start()
                failure_music_thread = threading.Thread(
                    target=play_failure_music(int_weight)
                )
                failure_music_thread.start()
                run_servo_motor_thread = threading.Thread(
                    target=run_servo_motor(int_weight)
                )
                run_servo_motor_thread.start()
                take_a_photo_thread = threading.Thread(take_a_photo(session_uuid))
                take_a_photo_thread.start()
                background_music_after_eating_thread = threading.Thread(
                    target=play_background_music_after_eating
                )
                background_music_after_eating_thread.start()

                # Make sure all threads are joined back and end the program.
                congrats_music_thread.join()
                failure_music_thread.join()
                run_servo_motor_thread.join()
                take_a_photo_thread.join()
                background_music_after_eating_thread.join()
                break

            time.sleep(0.1)

    except KeyboardInterrupt:
        clean_and_exit()
