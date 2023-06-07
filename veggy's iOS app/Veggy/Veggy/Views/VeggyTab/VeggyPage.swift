//
//  VeggyPage.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

struct VeggyPage: View {
    @ObservedObject var veggyPageViewModel: VeggyPageViewModel
    
    init(_ veggyPageViewModel: VeggyPageViewModel) {
        self.veggyPageViewModel = veggyPageViewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VeggyMilestoneHeader(veggyPageViewModel)
                .frame(height: UIScreen.main.bounds.height * 0.31)
            
            Divider()
                .overlay(.black)
                .frame(maxHeight: 1.5)
                .background(.black)
            
            RedeemRewardsView(veggyPageViewModel)
            
        }
    }
}

struct VeggyPage_Previews: PreviewProvider {
    static var previews: some View {
        let veggyPageViewModel = VeggyPageViewModel()
        
        VeggyPage(veggyPageViewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
