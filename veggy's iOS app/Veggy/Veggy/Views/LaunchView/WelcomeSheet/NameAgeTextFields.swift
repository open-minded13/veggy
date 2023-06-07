//
//  NameAgeTextFields.swift
//  Veggy
//
//  Created by Derrick Ding on 5/26/23.
//

import SwiftUI

struct NameAgeTextFields: View {
    @ObservedObject var welcomePageManager: WelcomePageManager
    
    init(_ welcomePageManager: WelcomePageManager) {
        self.welcomePageManager = welcomePageManager
    }
    
    var body: some View {
        VStack {
            TextField(
                "Name",
                value: $welcomePageManager.nameComponents,
                format: .name(style: .medium)
            )
            .asWelcomeForm()
            .disableAutocorrection(true)
            
            Spacer()
                .frame(height: 25)
            
            TextField(
                "Age",
                value: $welcomePageManager.ageText,
                format: .number
            )
            .asWelcomeForm()
            .keyboardType(.numberPad)
        }
    }
}

struct NameAgeTextFields_Previews: PreviewProvider {
    static var previews: some View {
        let veggySessionManager = VeggySessionManager()
        
        NameAgeTextFields(WelcomePageManager(with: veggySessionManager))
    }
}
