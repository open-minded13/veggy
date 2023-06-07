//
//  ContentView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

enum TabItem {
    case veggy
    case home
    case profile
}

class TabSelectionManager: ObservableObject {
    @Published var tabSelection = TabItem.home
    
    func setTabSelection(of newTabSelection: TabItem) {
        self.tabSelection = newTabSelection
    }
}

struct ContentView: View {
    @ObservedObject var tabSelectionManager: TabSelectionManager
    @ObservedObject var veggySessionManager: VeggySessionManager
    @ObservedObject var welcomePageManager: WelcomePageManager
    @ObservedObject var veggyPageViewModel: VeggyPageViewModel
    let contentviewIntentHandler: ContentViewIntentHandler
    
    init(
        _ tabSelectionManager: TabSelectionManager,
        _ veggySessionManager: VeggySessionManager,
        _ welcomePageManager: WelcomePageManager,
        _ contentviewIntentHandler: ContentViewIntentHandler,
        _ veggyPageViewModel: VeggyPageViewModel
    ) {
        self.tabSelectionManager = tabSelectionManager
        self.veggySessionManager = veggySessionManager
        self.welcomePageManager = welcomePageManager
        self.contentviewIntentHandler = contentviewIntentHandler
        self.veggySessionManager = veggySessionManager
        self.veggyPageViewModel = veggyPageViewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch tabSelectionManager.tabSelection {
            case .veggy:
                VeggyPage(veggyPageViewModel)
            case .home:
                HomePage(veggySessionManager)
            case .profile:
                ProfilePage()
            }
            
            Divider()
                .overlay(.black)
                .frame(minHeight: 1.5)
                .background(.black)
            
            VeggyTabBar(tabSelectionManager)
                .frame(height: UIScreen.main.bounds.height * 0.1)
        }
        .frame(maxHeight: .infinity)
        .onAppear() {
            // Copy Bundle file UserInfo.json to App Documents directory.
            contentviewIntentHandler.setVeggyUserData()
            
            // Reset userdata
            // TODO: Need Logout logic
            contentviewIntentHandler.resetVeggyUserData()
            
            if contentviewIntentHandler.getUser() == "" {
                veggySessionManager.userLoggedIn = false
            }
            
        }
        .popover(isPresented: Binding<Bool>(
            get: {
                return !veggySessionManager.userLoggedIn
            }, set: {
                p in veggySessionManager.userLoggedIn = p
            })) {
                WelcomePage(welcomePageManager, veggySessionManager)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let veggySessionManager = VeggySessionManager(forPreview: true)
        
        ContentView(TabSelectionManager(), veggySessionManager, WelcomePageManager(with: veggySessionManager), ContentViewIntentHandler(), VeggyPageViewModel())
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
