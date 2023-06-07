//
//  WelcomePage.swift
//  Veggy
//
//  Created by Derrick Ding on 5/26/23.
//

import SwiftUI

struct WelcomePage: View {
    @ObservedObject var welcomePageManager: WelcomePageManager
    @ObservedObject var veggySessionManager: VeggySessionManager
    
    init(
        _ welcomePageManager: WelcomePageManager,
        _ veggySessionManager: VeggySessionManager
    ) {
        self.welcomePageManager = welcomePageManager
        self.veggySessionManager = veggySessionManager
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome to veggy!")
                .asVeggyWelcomeInfo()
            
            VStack(alignment: .leading) {
                Text("We hope to collect some data to provide better")
                    .asSubInfo()
                
                Text("vegetable recommendation for you.")
                    .asSubInfo()
            }
            
            Spacer()
                .frame(height: 40)
            
            NameAgeTextFields(welcomePageManager)
            
            Spacer()
                .frame(height: 30)
            
            // MARK: - Start veggy button
            Button {
                // Two tasks.
                // Save name and age to UserInfo.json
                // Fetch Recommended Vegetables based on user age in the background
                
                print("Start veggy button clicked")
                
                welcomePageManager.saveNameAgeToUserInfo()
                
                // for fetch v2
                Task {
                    await welcomePageManager.fetchRecommendedVegetables(fromAge: welcomePageManager.ageText)
                }
                
                veggySessionManager.userDidLoggedIn()
                
                print("JSON: \(FileHandler.GetJSONDataFromFile(fileName: "UserInfo.json")!)")
            } label: {
                ZStack(alignment: .center) {
                    Image("StartVeggyButtonBg")
                        .resizable()
                        .frame(width: 164, height: 48)
                    Text("Start veggy")
                        .asVeggyButtonLabel(ofSize: 18, withWidth: 164, withHeight: 48)
                }
            }
            .foregroundColor(.black)
            .frame(width: 164, height: 48)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#F2FFF6"))
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        let veggySessionManager = VeggySessionManager()
        let welcomePageManager = WelcomePageManager(with: veggySessionManager)
        
        WelcomePage(welcomePageManager, veggySessionManager)
    }
}
