//
//  VegChoosingView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

struct VegChoosingView: View {
    @ObservedObject var manager: VeggySessionManager
    @State private var showingPopover: Bool = false
    
    init(_ veggySessionManager: VeggySessionManager) {
        self.manager = veggySessionManager
        self.showingPopover = showingPopover
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            HStack {
                Spacer()
                    .frame(width: 10)
                
                VStack(alignment: .leading) {
                    Text(manager.kidEatting ? "Vegetables" : "Choose Vegetable")
                        .font(.custom("Montserrat-SemiBold", size: 24))
                        .frame(minWidth: 240, alignment: .leading)
                    
                    Text(manager.kidEatting ? "Vegetables in process" : "Keep up to earn more points!")
                        .font(.custom("Lato-Regular", size: 12))
                        .frame(minWidth: 240, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
                
                StartStopMealButton(manager)
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "F2FFF6"))
            
            ScrollView {
                if manager.kidEatting {
                    VegProcessListView(manager)
                } else {
                    VegChoosingGridView(manager)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "F2FFF6"))
        }
        .background(Color(hex: "#F2FFF6"))
    }
}

struct VegChoosingView_Previews: PreviewProvider {
    static var previews: some View {
        VegChoosingView(VeggySessionManager(forPreview: true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
