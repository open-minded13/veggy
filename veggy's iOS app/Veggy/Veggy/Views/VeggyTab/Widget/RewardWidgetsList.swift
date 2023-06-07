//
//  RewardWidgetsList.swift
//  Veggy
//
//  Created by Derrick Ding on 5/27/23.
//

import SwiftUI

struct RewardWidgetsList: View {
    @ObservedObject var veggyPageViewModel: VeggyPageViewModel
    
    init(_ veggyPageViewModel: VeggyPageViewModel) {
        self.veggyPageViewModel = veggyPageViewModel
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 3) {
                Spacer()
                
                RewardWidget(veggyPageViewModel)
                
                RewardWidget(veggyPageViewModel)
                
                RewardWidget(veggyPageViewModel)
                
                RewardWidget(veggyPageViewModel)
            }
        }
    }
}

struct RewardWidgetsList_Previews: PreviewProvider {
    static var previews: some View {
        RewardWidgetsList(VeggyPageViewModel())
    }
}
