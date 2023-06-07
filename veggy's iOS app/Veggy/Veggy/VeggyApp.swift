//
//  VeggyApp.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

@main
struct VeggyApp: App {
    let veggySessionManager: VeggySessionManager
    let contentViewIntentHandler: ContentViewIntentHandler
    let welcomePageManager: WelcomePageManager
    let tabSelectionManager: TabSelectionManager
    let veggyPageViewModel: VeggyPageViewModel
    
    init() {
        self.veggySessionManager = VeggySessionManager()
        self.contentViewIntentHandler = ContentViewIntentHandler()
        self.welcomePageManager = WelcomePageManager(with: veggySessionManager)
        self.tabSelectionManager = TabSelectionManager()
        self.veggyPageViewModel = VeggyPageViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                tabSelectionManager,
                veggySessionManager,
                welcomePageManager,
                contentViewIntentHandler,
                veggyPageViewModel
            )
        }
    }
}
