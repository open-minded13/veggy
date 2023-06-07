//
//  VeggyVegetable.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import Foundation

struct VeggyVegetable: Identifiable {
    var id: String
    var name: String
    var weight: Float
    var points: Int
    var majorColorHex: String
}

struct VegetableToColorHex {
    static var pattern: [String : String] = [
        "cucumber": "91D25D",
        "carrot": "FB973B",
        "corn": "FBF7A1",
        "tomato": "FFB2A6",
        "cabbage": "B3EBC3",
        "broccoli": "B3EBC3",
        "cauliflower": "B3EBC3"
    ]
}
