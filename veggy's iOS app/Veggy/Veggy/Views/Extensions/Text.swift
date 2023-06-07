//
//  Text.swift
//  Veggy
//
//  Created by Derrick Ding on 6/1/23.
//

import Foundation
import SwiftUI

extension Text {
    func asSubInfo() -> some View {
        font(.custom("Lato-Regular", size: 12))
            .foregroundColor(Color(hex: "#5C5C5C"))
    }
    
    func asVeggyWelcomeInfo() -> some View {
        font(.custom("Montserrat-SemiBold", size: 32))
            .foregroundColor(.black)
    }
    
    func asVeggyButtonLabel(ofSize size: CGFloat, withWidth width: CGFloat, withHeight height: CGFloat) -> some View {
        font(.custom("Lato-Medium", size: size))
            .frame(width: width, height: height)
            .foregroundColor(.black)
    }
    
    func asTabInfo() -> some View {
        font(.custom("Montserrat-Medium", size: 12))
            .foregroundColor(.black)
    }
    
    func asVeggyHomeHeader() -> some View {
        font(.custom("Montserrat-Medium", size: 16))
            .foregroundColor(.black)
    }
    
    func asVeggyHomeHeading() -> some View {
        font(.custom("Montserrat-SemiBold", size: 24))
            .foregroundColor(.black)
    }
}
