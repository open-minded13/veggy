//
//  RewardWidget.swift
//  Veggy
//
//  Created by Derrick Ding on 5/27/23.
//

import SwiftUI

struct RewardWidget: View {
    @ObservedObject var veggyPageViewModel: VeggyPageViewModel
    
    // TODO: write them to struct variables
    @State private var showCurrentReward: Bool
    @State private var redeemPoints: Int
    
    init(_ veggyPageViewModel: VeggyPageViewModel) {
        self.veggyPageViewModel = veggyPageViewModel
        self.showCurrentReward = true
        self.redeemPoints = 60
    }
    
    var body: some View {
        if showCurrentReward {
            VStack {
                HStack(alignment: .top) {
                    Image("ShoppingTripRw")
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Spacer()
                        .frame(width: 3)
                    
                    Text("Shopping trip")
                        .font(.custom("Lato-Bold", size: 14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .frame(width: 82, height: 40)
                    
                    Spacer()
                        .frame(width: 5)
                    
                }
                
                Spacer()
                    .frame(height: 25)
                
                // MARK: - Redeem Button
                Button {
                    // TODO: add actual functions here
                    showCurrentReward = false
                    
                    veggyPageViewModel.addPoints(of: redeemPoints)
                } label: {
                    HStack {
                        Image("PointsIcon")
                            .resizable()
                            .frame(width: 12, height: 12)
                        
                        Text(String(redeemPoints))
                            .font(.custom("Lato-Bold", size: 11))
                            .foregroundColor(.black)
                        
                        Text("Redeem")
                            .font(.custom("Lato-Bold", size: 11))
                            .foregroundColor(.black)
                    }
                    .frame(width: 116, height: 26)
                    .background(Color(hex: "#FFC4CC"))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black)
                    )
                }
            }
            .frame(width: 140, height: 112)
            .background(.white)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(.black)
            )
            
            Spacer()
        }
    }
}

struct RewardWidget_Previews: PreviewProvider {
    static var previews: some View {
        RewardWidget(VeggyPageViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
