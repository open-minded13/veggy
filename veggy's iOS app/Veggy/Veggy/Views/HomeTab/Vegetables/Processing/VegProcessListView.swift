//
//  VegProcessListView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/5/23.
//

import SwiftUI

struct VegProcessListView: View {
    @ObservedObject var veggySessionManager: VeggySessionManager
    
    init(_ veggySessionManager: VeggySessionManager) {
        self.veggySessionManager = veggySessionManager
    }
    
    var body: some View {
        let selectedVegetables = veggySessionManager.selectedVegetables.map {$0.value}
        
        VStack {
            ForEach(selectedVegetables) { selectedVegetable in
                VegProcessListItemView(vegetableItem: selectedVegetable)
                    .listRowSeparator(.hidden)
            }
        }
        .background(Color(hex: "F2FFF6"))
    }
}

struct VegProcessListView_Previews: PreviewProvider {
    static var previews: some View {
        VegProcessListView(VeggySessionManager(forPreview: true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
