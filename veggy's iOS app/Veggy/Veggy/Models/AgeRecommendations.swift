//
//  AgeRecommendations.swift
//  Veggy
//
//  Created by Derrick Ding on 6/2/23.
//

import Foundation

struct Recommendation: Codable {
    var ages: [Int]
    var food: [String: Int]
}

struct AgeRecommendations: Identifiable, Codable {
    var id: String
    var data: [Recommendation]
}

enum ConversionError: Error {
    case ageNotFound
    case hexCodeNotFound
}

struct AgeRecommendationsToVeggyVegetableConverter {
    static func convert(from ageRecommendations: AgeRecommendations, ofAge age: Int) throws -> [VeggyVegetable] {
        let recommendations = ageRecommendations.data
        
        var vegetableWeightDict = [String: Int]()
        var convertedVeggyVegetables = [VeggyVegetable]()
        
        for recommendation in recommendations {
            if recommendation.ages.contains(age) {
                vegetableWeightDict = recommendation.food
                
                break
            }
        }
        
        // throw ageNotFound error when vegetableWeightDict is not assigned a value
        guard !vegetableWeightDict.isEmpty else {
            throw ConversionError.ageNotFound
        }
        
        for (vegetableName, vegetableWeight) in vegetableWeightDict {
            
            // throw hexCodeNotFound when this vegetable is not registered in Veggy
            guard VegetableToColorHex.pattern.keys.contains(vegetableName) else {
                throw ConversionError.hexCodeNotFound
            }
            
            convertedVeggyVegetables.append(
                VeggyVegetable(
                    id: vegetableName,
                    name: vegetableName,
                    weight: Float(vegetableWeight),
                    points: vegetableWeight,  // points are the same of the weight
                    majorColorHex: VegetableToColorHex.pattern[vegetableName]!
                )
            )
        }
        
        return convertedVeggyVegetables
    }
}
