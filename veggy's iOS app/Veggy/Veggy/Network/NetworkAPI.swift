//
//  NetworkAPI.swift
//  Veggy
//
//  Created by Derrick Ding on 6/2/23.
//

import Foundation
import Alamofire

class NetworkAPI {
    static func getVeggyVegetables(ofAge age: Int) async -> [VeggyVegetable]? {
        do {
            let data = try await NetworkManager.shared.get(
                baseURL: Config.AZURE_BASE_URL,
                route: "/configuration/age-recommendations",
                parameters: nil
            )
            
            let ageRecommendations: AgeRecommendations = try self.parseData(data: data)
            
            let veggyVegetables: [VeggyVegetable] = try AgeRecommendationsToVeggyVegetableConverter.convert(from: ageRecommendations, ofAge: age)
            
            return veggyVegetables
        } catch ConversionError.ageNotFound {
            print("Age Not Found")
            
            return nil
        } catch ConversionError.hexCodeNotFound {
            print("Vegetable Type Not Found")
            
            return nil
        } catch let error {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    static func getLatestSessionUuid() async -> String? {
        do {
            let data = try await NetworkManager.shared.get(
                baseURL: Config.AZURE_BASE_URL,
                route: "/session/latest-session",
                parameters: nil
            )
            
            let latest_session: Session = try self.parseData(data: data)
            
            return latest_session.latest_session_uuid
        } catch let error {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    static func getVeggyWeight(ofType type: VeggyWeightType) async -> VeggyWeight? {
        if let latestSessionUuid = await getLatestSessionUuid() {
            do {
                let data = try await NetworkManager.shared.get(
                    baseURL: Config.AZURE_BASE_URL,
                    route: "/weight/\(latestSessionUuid)-\(type.rawValue)_weight",
                    parameters: nil
                )
                
                let veggyWeight: VeggyWeight = try self.parseData(data: data)
                
                return veggyWeight
            } catch let error {
                print(error.localizedDescription)
                
                return nil
            }
        } else {  // error handling
            return nil
        }
    }
    
    static func getVegetableRecognition(confidence: Int, overlap: Int) async -> VegetableRecognition? {
        if let latestSessionUuid = await getLatestSessionUuid() {
            do {
                let data = try await NetworkManager.shared.get(
                    baseURL: Config.RECOGNITION_BASE_URL,
                    route: "/analyze/v2/\(latestSessionUuid)",
                    parameters: [
                        "confidence": String(confidence),
                        "overlap": String(overlap)
                    ]
                )
                
                let vegetableRecognition: VegetableRecognition = try self.parseData(data: data)
                
                return vegetableRecognition
            } catch let error {
                print(error.localizedDescription)
                
                print("debug here")
                
                return nil
            }
            
        } else { // error handling
            return nil
        }
    }
}

// MARK: - private functions
extension NetworkAPI {
    private static func parseData<T: Decodable>(data: Data) throws -> T {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
                
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "\(T.self) JSON decode error"]
            )
        }
        
        return decodedData
    }
}
