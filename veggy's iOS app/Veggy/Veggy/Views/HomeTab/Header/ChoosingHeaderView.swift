//
//  ChoosingHeaderView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

struct ChoosingHeaderView: View {
    @ObservedObject var veggySessionManager: VeggySessionManager
    
    init(_ veggySessionManager: VeggySessionManager) {
        self.veggySessionManager = veggySessionManager
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            HStack {
                Spacer()
                    .frame(width: 3)
                
                VStack(alignment: .leading) {
                    Text("Veggy")
                        .asVeggyHomeHeader()
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Progress for today")
                            .asVeggyHomeHeading()
                        
                        Spacer()
                        
                        Text("Complete today's recommendation to earn 1 milestone!")
                            .asSubInfo()
                    }
                    
                }
                .frame(width: 340, height: 100)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 20)
            
            // TODO: Change this to a separate view
            Text("")
                .font(.custom("Montserrat-Medium", size: 14))
        }
        .frame(maxHeight: .infinity)
        .background(Color(hex: "#FFE7A8"))
    }
}

struct ChoosingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let veggySessionManager = VeggySessionManager()
        
        ChoosingHeaderView(veggySessionManager)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
