//
//  HomePage.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

struct HomePage: View {
    @ObservedObject var veggySessionManager: VeggySessionManager
    
    init(_ veggySessionManager: VeggySessionManager) {
        self.veggySessionManager = veggySessionManager
    }
    
    var body: some View {
        if veggySessionManager.recommendedVegetables.count == 0 {
//        if veggySessionManager.recommendedVegetables.count == 0 {
            ProgressView()
                .frame(maxHeight: .infinity)
        } else {
            VStack(spacing: 0) {
                if veggySessionManager.kidEatting {
                    ProcessingHeaderView(veggySessionManager)
                        .frame(height: UIScreen.main.bounds.height * 0.31)
                } else {
                    ChoosingHeaderView(veggySessionManager)
                        .frame(height: UIScreen.main.bounds.height * 0.31)
                }
                
                Divider()
                    .overlay(.black)
                    .frame(minHeight: 1.5)
                    .background(.black)
                
                VegChoosingView(veggySessionManager)
                    .frame(maxHeight: .infinity)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        let veggySessionManager = VeggySessionManager(forPreview: true)
        
        HomePage(veggySessionManager)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
