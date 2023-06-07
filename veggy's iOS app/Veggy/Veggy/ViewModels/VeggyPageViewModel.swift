//
//  VeggyPageViewModel.swift
//  Veggy
//
//  Created by Derrick Ding on 6/2/23.
//

import Foundation

class VeggyPageViewModel: ObservableObject {
    @Published var points: Int = 11235
    
    func addPoints(of points: Int) {
        self.points += points
    }
}
