//
//  TextField.swift
//  Veggy
//
//  Created by Derrick Ding on 6/2/23.
//

import Foundation
import SwiftUI

extension TextField {
    func asWelcomeForm() -> some View {
        frame(width: 347, height: 48)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .textFieldStyle(PlainTextFieldStyle())
            .background(.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black)
            )
    }
}
