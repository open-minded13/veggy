//
//  VeggyMilestoneHeader.swift
//  Veggy
//
//  Created by Derrick Ding on 5/27/23.
//

import SwiftUI

struct VeggyMilestoneHeader: View {
    @ObservedObject var veggyPageViewModel: VeggyPageViewModel
    
    init(_ veggyPageViewModel: VeggyPageViewModel) {
        self.veggyPageViewModel = veggyPageViewModel
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
                        .font(.custom("Montserrat-Medium", size: 16))
                    
                    Spacer()
                        .frame(height: 30)
                    
                    VStack(alignment: .leading) {
                        Text("Current Milestone")
                            .font(.custom("Montserrat-SemiBold", size: 24))
                        
                        Spacer()
                        
                        Text("Keep working! You are close to reward.")
                            .font(.custom("Lato-Regular", size: 12))
                            .foregroundColor(Color(hex: "958254"))
                    }
                    
                }
                .frame(maxWidth: 300, maxHeight: 100)
                
                Spacer()
                    .frame(width: 120)
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            
            Spacer()
                .frame(height: 20)
            
            
            HStack {
                Spacer()
                    .frame(width: 15)
                
                Image("MilestoneCup")
                    .resizable()
                    .frame(width: 72, height: 72)
                
                Spacer()
                    .frame(width: 20)
                
                VStack(alignment: .leading) {
                    Text(String(veggyPageViewModel.points))
                        .font(.custom("Lato-ExtraBold", size: 36))
                    
                    Text("points available")
                        .font(.custom("Lato-Bold", size: 12))
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 72)
                        
        }
        .frame(maxHeight: .infinity)
        .background(Color(hex: "#FFE7A8"))
    }
}

struct VeggyMilestoneHeader_Previews: PreviewProvider {
    static var previews: some View {
        let veggyPageViewModel = VeggyPageViewModel()
        
        VeggyMilestoneHeader(veggyPageViewModel)
    }
}
