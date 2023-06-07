//
//  RedeemRewardsView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/27/23.
//

import SwiftUI

struct RedeemRewardsView: View {
    @ObservedObject var veggyPageViewModel: VeggyPageViewModel
    
    init(_ veggyPageViewModel: VeggyPageViewModel) {
        self.veggyPageViewModel = veggyPageViewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 15)
            
            VStack(alignment: .leading) {
                // MARK: - Redeem Rewards
                Text("Redeem Rewards")
                    .font(.custom("Montserrat-SemiBold", size: 24))
                    .foregroundColor(.black)
                
                Text("Work with your parents to create and redeem rewards!")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundColor(Color(hex: "#7C8F82"))
                
                Spacer()
                    .frame(height: 30)
                
                RewardWidgetsList(veggyPageViewModel)
                
                Spacer()
                    .frame(height: 25)
                
                // TODO: Add actual function to the button
                Button {
                    
                } label: {
                    ZStack {
                        Image("CreateNewButtonBg")
                            .resizable()
                            .frame(width: 164, height: 48)
                        
                        Text("Create New")
                            .font(.custom("Lato-Medium", size: 18))
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
                    .frame(height: 30)
                
                // MARK: - Earn Extra Points
                Text("Earn Extra Points")
                    .font(.custom("Montserrat-SemiBold", size: 24))
                    .foregroundColor(.black)
                
                Text("Kepp continuous progress for extra points!")
                    .font(.custom("Lato-Regular", size: 12))
                    .foregroundColor(Color(hex: "#7C8F82"))
                
                ScrollView(.vertical) {
                    VStack(spacing: 15) {
                        ExtraPointWidget()
                        
                        ExtraPointWidget()
                        
                        ExtraPointWidget()
                    }
                }
                
                
//                Spacer()
                
            }
            
            Spacer()
            
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#F2FFF6"))
    }
}

struct RedeemRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RedeemRewardsView(VeggyPageViewModel())
    }
}
