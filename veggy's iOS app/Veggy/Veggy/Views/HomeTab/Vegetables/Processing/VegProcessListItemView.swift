//
//  VegProcessListItemView.swift
//  Veggy
//
//  Created by Derrick Ding on 5/4/23.
//

import SwiftUI

struct VegProcessListItemView: View {
    var vegetableItem: VeggyVegetable
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            
            Image(vegetableItem.id)
                .resizable()
                .frame(width: 76, height: 76)
            
            Spacer()
                .frame(width: 10)
            
            VStack(alignment: .leading) {
                Text(vegetableItem.name)
                    .font(.custom("Montserrat-SemiBold", size: 18))
                    .frame(minWidth: 150, alignment: .leading)
                
                // TODO: Vegetable weight measurement
                Text(String(Int(vegetableItem.weight)) + "g")
                    .font(.custom("Lato-Medium", size: 12))
                    .frame(minWidth: 150, alignment: .leading)
            }
            
            
            
            Spacer()
                .frame(width: 80)
            
            HStack {
                Image("PointsIcon")
                    .resizable()
                    .frame(width: 18, height: 18)
                
                Spacer()
                    .frame(width: 3)
                
                Text(String(vegetableItem.points))
                    .font(.custom("Lato-Bold", size: 18))
            }
//            .frame(maxWidth: .infinity)
            
            Spacer()
                .frame(width: 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "F2FFF6"))
    }
}

struct VegProcessListItemView_Previews: PreviewProvider {
    static var previews: some View {
        VegProcessListItemView(
            vegetableItem: VeggyVegetable(
                id: "carrot",
                name: "Carrot",
                weight: 40,
                points: 20,
                majorColorHex: "FB973B"
            )
        )
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
    }
}
