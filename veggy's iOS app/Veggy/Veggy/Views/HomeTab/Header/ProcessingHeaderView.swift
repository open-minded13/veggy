//
//  ProcessingHeaderView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/4/23.
//

import SwiftUI

struct ProcessingHeaderView: View {
    @ObservedObject var manager: VeggySessionManager
    @State private var statusText: String
    
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    init(_ manager: VeggySessionManager) {
        self.manager = manager
        self.statusText = "Fetching data from Azure.."
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
                        Text("Progress")
                            .asVeggyHomeHeading()
                        
                        Spacer()
                        
                        Text("Meal left in your bowl")
                            .asSubInfo()
                    }
                    
                }
                .frame(width: 150, height: 100)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                VStack {
//                    Text("Initial weight: 491g")
//                        .font(.custom("Lato-Regular", size: 16))
//                        .frame(width: 257, alignment: .leading)
                    
                    // TODO: add visibility condition
                    
                    
                    Text(statusText)
                        .font(.custom("Lato-Regular", size: 16))
                        .frame(width: 257, alignment: .leading)
                }
                
                Image("ProgressBowl")
                    .resizable()
                    .frame(width: 96, height: 76)
            }
            .frame(maxWidth: .infinity)
        }
        .onReceive(timer) { _ in
            manager.fetchSessionUuid { sessionUuid in
                manager.fetchCurrentInstruction(sessionUuid: sessionUuid) { instruction in
                    statusText = instruction
                }
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color(hex: "#FFE7A8"))
    }
}

struct ProcessingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProcessingHeaderView(VeggySessionManager(forPreview: true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
