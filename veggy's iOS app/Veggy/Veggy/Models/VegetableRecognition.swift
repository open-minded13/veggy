//
//  VegetableRecognition.swift
//  Veggy
//
//  Created by Derrick Ding on 6/4/23.
//

import Foundation

struct VeggyRecognitionImage: Decodable {
    var width: String
    var height: String
}

struct Prediction: Decodable {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var confidence: Double
    var image_path: String
    var prediction_type: String
    var predicted_class: String
}

struct VegetableRecognition: Decodable {
    var image: VeggyRecognitionImage
    var predictions: [Prediction]
}
