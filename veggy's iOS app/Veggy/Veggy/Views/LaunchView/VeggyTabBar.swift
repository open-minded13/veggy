//
//  VeggyTabBar.swift
//  Veggy
//
//  Created by Derrick Ding on 5/27/23.
//

import SwiftUI



struct VeggyTabBar: View {
    @ObservedObject var tabSelectionManager: TabSelectionManager
    
    init(_ tabSelectionManager: TabSelectionManager) {
        self.tabSelectionManager = tabSelectionManager
    }
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 40)
            
            Button {
                // Set tab content
                tabSelectionManager.setTabSelection(of: .veggy)
            } label: {
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(hex: tabSelectionManager.tabSelection == .veggy ? "#FEDD88" : "#79F39C"))
                            .frame(width: 48, height: 48)
                        
                        Image("veggy")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("Veggy")
                        .asTabInfo()
                }
                .frame(height: 80)
            }
            .animation(.easeInOut(duration: 0.5), value: tabSelectionManager.tabSelection == .veggy)
            
            Spacer()
            
            Button {
                tabSelectionManager.setTabSelection(of: .home)
            } label: {
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(hex: tabSelectionManager.tabSelection == .home ? "#FEDD88" : "#79F39C"))
                            .frame(width: 48, height: 48)
                        
                        Image("home")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("Home")
                        .asTabInfo()
                }
                .frame(height: 80)
            }
            .animation(.easeInOut(duration: 0.5), value: tabSelectionManager.tabSelection == .home)
            
            Spacer()
            
            Button {
                tabSelectionManager.setTabSelection(of: .profile)
            } label: {
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(hex: tabSelectionManager.tabSelection == .profile ? "#FEDD88" : "#79F39C"))
                            .frame(width: 48, height: 48)
                        
                        Image("profile")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Text("Profile")
                        .asTabInfo()
                }
                .frame(height: 80)
            }
            .animation(.easeInOut(duration: 0.5), value: tabSelectionManager.tabSelection == .profile)
            
            Spacer()
                .frame(width: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#79F39C"))
    }
}

struct VeggyTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VeggyTabBar(TabSelectionManager())
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
