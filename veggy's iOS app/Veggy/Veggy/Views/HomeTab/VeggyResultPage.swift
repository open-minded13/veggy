//
//  VeggyResultPage.swift
//  Veggy
//
//  Created by Derrick Ding on 5/6/23.
//

import SwiftUI

struct VeggyResultPage: View {
    @ObservedObject var veggySessionManager: VeggySessionManager
    @Environment(\.dismiss) var dismiss
    
    init(_ veggySessionManager: VeggySessionManager) {
        self.veggySessionManager = veggySessionManager
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 3)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text("Veggy")
                        .asVeggyHomeHeader()
                    
                    Spacer()
                    
                    Text(veggySessionManager.foodDidFinished ? "Congrats!" : "Sorry!")
                        .asVeggyHomeHeading()
                    
                    Text(veggySessionManager.foodDidFinished ? "You completed your task!" : "You did not complete your task!")
                        .asVeggyHomeHeading()
                    
                    Spacer()
                    
                    Text("Select more tasks to earn rewards!")
                        .asSubInfo()
                    
                    Spacer()
                    
                }
                .frame(width: 340, height: 200)
                
                Spacer()
            }
            
            
            VStack {
                Image(veggySessionManager.foodDidFinished ? "Gift" : "GrinningFace")
                    .resizable()
                    .frame(width: 70, height: 70)
                
                // MARK: - Back to Home button
                Button {
                    print("Back to home button clicked")
                    
                    dismiss()
                } label: {
                    ZStack {
                        Image("BackToHomeButtonBg")
                            .resizable()
                            .frame(width: 164, height: 48)
                        
                        Text("Back to Home")
                            .font(.custom("Lato-Medium", size: 18))
                            .foregroundColor(.black)
                            .frame(width: 164, height: 48)
                    }
                }
                
                // TODO: change points here
                Text(veggySessionManager.foodDidFinished ? "You earned \(String(veggySessionManager.calcTotalPoints())) points!" : "Try again next time!")
                    .asVeggyHomeHeading()
                
                Text("End Weight: " + String(veggySessionManager.finishWeight) + " g")
                    .font(.custom("Lato-Regular", size: 16))
                                
                if !veggySessionManager.foodDidFinished {
                    Text("Vegetable left: " + veggySessionManager.foodRecognitionResult)
                        .lineLimit(nil)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color(hex: "FFE7A8"))
    }
}

struct VeggyResultPage_Previews: PreviewProvider {
    static var previews: some View {
        VeggyResultPage(VeggySessionManager(forPreview: true))
    }
}
