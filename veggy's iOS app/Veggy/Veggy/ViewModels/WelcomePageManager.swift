//
//  WelcomePageManager.swift
//  Veggy
//
//  Created by Derrick Ding on 5/26/23.
//

import Foundation

class WelcomePageManager: ObservableObject {
    @Published var nameComponents: PersonNameComponents
    @Published var ageText: Int
    
    var veggySessionManager: VeggySessionManager
    
    init(with veggySessionManager: VeggySessionManager) {
        self.nameComponents = PersonNameComponents()
        self.ageText = 0
        self.veggySessionManager = veggySessionManager
    }
    
    func saveNameAgeToUserInfo() {
        let givenName: String = self.nameComponents.givenName ?? ""
        
        let json = FileHandler.GetJSONDataFromFile(fileName: "UserInfo.json")
        
        if var json = json {
            json["name"].string = givenName
            json["age"].int = ageText
            
            // Save User entered info to Documents
            if let encodedData = try? JSONEncoder().encode(json) {
                FileHandler.SaveJSONDataToFile(json: encodedData, fileName: "UserInfo.json")
            }
        }
    }
    
    func fetchRecommendedVegetables(fromAge age: Int) async {
        await MainActor.run {
            veggySessionManager.fetchRecommendedVegetablesErrorMessage = ""
        }

        if let veggyVegetables = await NetworkAPI.getVeggyVegetables(ofAge: age) {
            await MainActor.run {
                veggySessionManager.recommendedVegetables = veggyVegetables
            }
        } else {
            await MainActor.run {
                veggySessionManager.fetchRecommendedVegetablesErrorMessage = "Fetch data failed"
            }
        }
    }
}
