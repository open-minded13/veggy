//
//  RecommendationManager.swift
//  Veggy
//
//  Created by Derrick Ding on 5/26/23.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RecommendationManager {
    static func GetRecommendedVegetables(fromAge ageEntry: Int, completion: @escaping([VeggyVegetable]) -> Void) {
        AF.request("\(Config.AZURE_BASE_URL)/configuration/age-recommendations")
            .responseDecodable(of: JSON.self) { response in
                switch response.result {
                case .success(let value):
                    let data: [JSON] = value["data"].arrayValue
                    var recommendedVegetables = [VeggyVegetable]()
                    
                    // Start searching
                    var found: Bool = false
                    for entry in data {
                        if !found {
                            let ageGroup: [JSON] = entry["ages"].arrayValue
                                                        
                            for age in ageGroup {
                                if age.intValue == ageEntry {
                                    found = true
                                    
                                    let foodDict = entry["food"].object as? [String : Int]
                                    if let foodDict = foodDict {
                                        foodDict.keys.forEach { foodName in
                                            recommendedVegetables.append(
                                                VeggyVegetable(
                                                    id: foodName,
                                                    name: foodName,
                                                    weight: Float(foodDict[foodName]!),
                                                    points: foodDict[foodName]!,
                                                    majorColorHex: VegetableToColorHex.pattern[foodName] ?? "FF0000"
                                                )
                                            )
                                        }
                                    }
                                    break
                                }
                            }
                        }
                    }
                    
                    completion(recommendedVegetables)
                    
                case .failure(let error):
                    print(error)
                }
            }.resume()
    }
}
