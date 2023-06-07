//
//  VeggySessionManager.swift
//  Veggy
//
//  Created by Derrick Ding on 5/4/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class VeggySessionManager: ObservableObject {
    @Published var kidEatting: Bool
    @Published var selectedVegetables: [String : VeggyVegetable]  // id to object
    @Published var recommendedVegetables: [VeggyVegetable]  // for async await
    @Published var fetchRecommendedVegetablesErrorMessage = ""
    @Published var sessionUuid: UUID
    @Published var startWeight: Float
    @Published var finishWeight: Float
    @Published var foodRecognitionResult: String
    @Published var vegetableRecognition: VegetableRecognition?
    @Published var foodDidFinished: Bool
    @Published var userLoggedIn: Bool
    
    init() {
        self.kidEatting = false
        self.selectedVegetables = [String : VeggyVegetable]()
        self.recommendedVegetables = [VeggyVegetable]()
        self.sessionUuid = UUID()
        self.startWeight = 0.0
        self.finishWeight = 0.0
        self.foodRecognitionResult = "N/A"
        self.foodDidFinished = false
        self.userLoggedIn = false
    }
    
    init(forPreview: Bool) {
        self.kidEatting = false
        self.selectedVegetables = [
            "cucumber": VeggyVegetable(id: "cucumber", name: "Cucumber", weight: 30, points: 20, majorColorHex: "91D25D"),
            "carrot": VeggyVegetable(id: "carrot", name: "Carrot", weight: 30, points: 20, majorColorHex: "FB973B")
        ]
        self.recommendedVegetables = [
            VeggyVegetable(
                id: "cucumber",
                name: "Cucumber",
                weight: 40,
                points: 20,
                majorColorHex: "91D25D"
            ),
            VeggyVegetable(
                id: "carrot",
                name: "Carrot",
                weight: 40,
                points: 20,
                majorColorHex: "FB973B"
            ),
            VeggyVegetable(
                id: "corn",
                name: "Corn",
                weight: 40,
                points: 20,
                majorColorHex: "FBF7A1"
            ),
            VeggyVegetable(
                id: "tomato",
                name: "Tomato",
                weight: 40,
                points: 20,
                majorColorHex: "FFB2A6"
            ),
            VeggyVegetable(
                id: "cabbage",
                name: "Cabbage",
                weight: 40,
                points: 20,
                majorColorHex: "B3EBC3"
            ),
        ]
        self.sessionUuid = UUID()
        self.startWeight = 0.0
        self.finishWeight = 0.0
        self.foodRecognitionResult = "N/A"
        self.foodDidFinished = true
        self.userLoggedIn = false
    }
    
    func calcTotalPoints() -> Int {
        var totalPoints: Int = 0
        
        for vegetable in self.selectedVegetables.values {
            totalPoints += vegetable.points
        }
        
        return totalPoints
    }
    
    func fetchSessionUuid(completion: @escaping(String) -> Void) {
        AF.request("\(Config.AZURE_BASE_URL)/session/latest-session")
            .responseDecodable(of: JSON.self) { response in
                switch response.result {
                case .success(let value):
                    completion(JSON(value)["latest_session_uuid"].stringValue)
                case .failure(let error):
                    print(error)
                }
            }.resume()
    }
    
    func fetchCurrentInstruction(sessionUuid: String, completion: @escaping(String) -> Void) {
        self.fetchSessionUuid { sessionUuid in
            AF.request("\(Config.AZURE_BASE_URL)/instruction/\(sessionUuid)-current_instruction")
                .responseDecodable(of: JSON.self) { response in
                    switch response.result {
                    case .success(let value):
                        let currentInstruction = JSON(value)["current_instruction"]
                        
                        if currentInstruction == "start_process" {
                            completion("Press button to start")
                        } else if currentInstruction == "start_calibrate" {
                            completion("The scale will calibrate in 5 sec")
                        } else if currentInstruction == "start_weighing" {
                            completion("Put item into the bowl. Press button to continue.")
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                }.resume()
        }
    }
    
    func kidStartEatting() async {
//        if let startWeight = await NetworkAPI.getVeggyWeight(ofType: .start) {
//            await MainActor.run {
//                self.kidEatting = startWeight.is_eating
//                self.startWeight = startWeight.weight
//            }
//        } else {
//            // error handling
//        }
        
        await MainActor.run {
            self.kidEatting = true
            self.startWeight = 0.0
        }
    }
    
    func kidStopEatting() async {
        if let finishWeight = await NetworkAPI.getVeggyWeight(ofType: .finish) {
            await MainActor.run {
                self.kidEatting = finishWeight.is_eating
                
                self.finishWeight = finishWeight.weight
            }
            
            if let vegetableRecognition = await NetworkAPI.getVegetableRecognition(confidence: 3, overlap: 20) {
                await MainActor.run {
                    self.vegetableRecognition = vegetableRecognition
                    
                    if vegetableRecognition.predictions.count == 0 || self.finishWeight <= 5.0 {
                        self.foodDidFinished = true
                    } else {
                        self.foodDidFinished = false
                        
                        // assign food recognition result
                        var detectedFoodSet = Set<String>()
                        for prediction in vegetableRecognition.predictions {
                            detectedFoodSet.insert(prediction.predicted_class)
                        }
                        
                        self.foodRecognitionResult = detectedFoodSet.joined(separator: ", ")
                    }
                }
            } else {
                // error handling
            }
        } else {
            // error handling
        }
    }
    
    func addSelectedVegetable(_ vegetable: VeggyVegetable) {
        self.selectedVegetables[vegetable.id] = vegetable
    }
    
    func removeSelectedVegetable(_ vegetable: VeggyVegetable) {
        self.selectedVegetables.removeValue(forKey: vegetable.id)
    }
}

// For User login and logout
extension VeggySessionManager {
    func userDidLoggedIn() {
        self.userLoggedIn = true
    }
    
    func userDidLoggedOut() {
        self.userLoggedIn = false
    }
}
