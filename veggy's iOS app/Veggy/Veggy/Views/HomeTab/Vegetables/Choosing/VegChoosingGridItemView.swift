//
//  VegChoosingGridItemView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/2/23.
//

import SwiftUI

struct VegChoosingGridItemView: View {
    var vegetableItem: VeggyVegetable
    @ObservedObject var veggySessionManager: VeggySessionManager
    @State var userSelected: Bool = false
    
    init(
        veggyVeg vegetableItem: VeggyVegetable,
        _ veggySessionManager: VeggySessionManager
    ) {
        self.vegetableItem = vegetableItem
        self.veggySessionManager = veggySessionManager
    }
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                // Image resource name has to be as the same as vegetable name
                Image(vegetableItem.id)
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(vegetableItem.name)
                        .font(.custom("Lato-Medium", size: 12))
                    
                    Spacer()
                        .frame(width: 65)
                    
                    // TODO: Vegetable weight measurement
                    Text(String(Int(vegetableItem.weight)) + "g")
                        .font(.custom("Lato-Medium", size: 12))
                }
                
                HStack(alignment: .center) {
                    HStack {
                        Image("PointsIcon")
                            .resizable()
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                            .frame(width: 3)
                        
                        Text(String(vegetableItem.points))
                            .font(.custom("Lato-Bold", size: 12))
                    }
                    
                    Spacer()
                        .frame(width: 30)
                    
                    Button {
                        print("select button clicked")
                        veggySessionManager.addSelectedVegetable(vegetableItem)
                        userSelected = true
                    } label: {
                        ZStack(alignment: .center) {
                            Image("SelectButtonBg")
                                .resizable()
                                .frame(width: 82, height: 33)
                            Text(userSelected ? "Selected" : "Select")
                                .asVeggyButtonLabel(ofSize: 14, withWidth: 82, withHeight: 33)
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width: 82, height: 33)
                }
            }
            .frame(width: 168, height: 92)
            .background(Color(hex: vegetableItem.majorColorHex))
            .cornerRadius(22.61)
            .overlay(
                RoundedRectangle(cornerRadius: 22.61)
                    .stroke(.black, lineWidth: 1)
            )
        }
        .background(.white)
        .frame(width: 168, height: 257)
        .cornerRadius(22.61)
        .overlay(
            RoundedRectangle(cornerRadius: 22.61)
                .stroke(.black, lineWidth: 1)
        )
    }
}

struct VegChoosingGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        VegChoosingGridItemView(
            veggyVeg: VeggyVegetable(
                id: "cucumber",
                name: "Cucumber",
                weight: 60,
                points: 15,
                majorColorHex: "91D25D"
            ),
            VeggySessionManager()
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
