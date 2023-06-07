//
//  StartStopMealButton.swift
//  Veggy
//
//  Created by Derrick Ding on 6/2/23.
//

import SwiftUI

struct StartStopMealButton: View {
    @ObservedObject var veggySessionManager: VeggySessionManager
    @State private var showingPopover: Bool = false
    
    init(_ veggySessionManager: VeggySessionManager) {
        self.veggySessionManager = veggySessionManager
        self.showingPopover = showingPopover
    }
    
    var body: some View {
        Button {
            print("Start meal button clikced")
            
            if veggySessionManager.kidEatting { // stop
                Task {
                    await veggySessionManager.kidStopEatting()
                }
                
                self.showingPopover = true
            } else {  // start
                Task {
                    await veggySessionManager.kidStartEatting()
                }
            }
        } label: {
            ZStack {
                Image("StartStopMealButtonBg")
                    .resizable()
                    .frame(width: 130, height: 48)
                
                Text(veggySessionManager.kidEatting ? "Finish" : "Start meal")
                    .asVeggyButtonLabel(ofSize: 18, withWidth: 130, withHeight: 48)
            }
        }
        .popover(isPresented: $showingPopover) { // show result
            if veggySessionManager.vegetableRecognition == nil {
                ProgressView()
            } else {
                VeggyResultPage(veggySessionManager)
            }
        }
    }
}

struct StartStopMealButton_Previews: PreviewProvider {
    static var previews: some View {
        StartStopMealButton(VeggySessionManager(forPreview: true))
    }
}
