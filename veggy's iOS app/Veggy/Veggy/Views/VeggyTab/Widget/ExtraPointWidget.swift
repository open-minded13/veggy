//
//  ExtraPointWidget.swift
//  Veggy
//
//  Created by Derrick Ding on 5/27/23.
//

import SwiftUI

struct ExtraPointWidget: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Image("MilestoneRw")
                
                Spacer()
                    .frame(width: 30)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Milestone Reward")
                            .font(.custom("Lato-Semibold", size: 12))
                            .foregroundColor(.black)
                        
                        Spacer()
                            .frame(width: 60)
                        
                        Image("PointsIcon")
                            .resizable()
                            .frame(width: 14, height: 14)
                        
                        Text("100")
                            .font(.custom("Lato-Bold", size: 12))
                    }
                    
                    
                    Image("TempMilestoneRwProgress")
                    
                    Text("4 Milestone left")
                        .font(.custom("Lato-Medium", size: 8))
                        .foregroundColor(.black)
                    
                }
                
                Spacer()
                
            }
            
            Spacer()
        }
        .frame(width: 348, height: 91)
        .background(.white)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(.black)
        )
        
    }
}

struct ExtraPointWidget_Previews: PreviewProvider {
    static var previews: some View {
        ExtraPointWidget()
    }
}
