//
//  VeggyWeight.swift
//  Veggy
//
//  Created by Derrick Ding on 6/3/23.
//

import Foundation

enum VeggyWeightType: String, CaseIterable {
    case start = "start"
    case finish = "finish"
}

struct VeggyWeight: Decodable {
    var weight: Float
    var is_eating: Bool
    var session_uuid: String
}
