//
//  VegChoosingGridView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/5/23.
//

import SwiftUI

struct VegChoosingGridView: View {
    @ObservedObject var manager: VeggySessionManager
    
    init(_ manager: VeggySessionManager) {
        self.manager = manager
    }
    
    var body: some View {
        Grid {
            ForEach(0..<Int(manager.recommendedVegetables.count / 2)) { rowIndex in
                GridRow {
                    VegChoosingGridItemView(
                        veggyVeg: manager.recommendedVegetables[2 * rowIndex], manager
                    )
                    VegChoosingGridItemView(
                        veggyVeg: manager.recommendedVegetables[2 * rowIndex + 1], manager
                    )
                }
            }
            
            if manager.recommendedVegetables.count % 2 != 0 {
                GridRow {
                    VegChoosingGridItemView(
                        veggyVeg: manager.recommendedVegetables.last!,
                        manager
                    )
                }
            }
        }
    }
}

struct VegChoosingGridView_Previews: PreviewProvider {
    static var previews: some View {
        VegChoosingGridView(VeggySessionManager(forPreview: true))
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
