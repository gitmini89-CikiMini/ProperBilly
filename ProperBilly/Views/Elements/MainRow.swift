//
//  MainRow.swift
//  ProperBilly
//
//  Created by Mi Ni on 04/11/2025.
//

import SwiftUI

struct MainRow: View {
    let propertyImage: Image?
    let propertyName: String
    let propertyType: String
    let propertyAddressLine_1: String
    let propertyAddressLine_2: String
    
    let propertyColor: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            propertyColor
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
            
            HStack(spacing: -10) {
                (propertyImage ?? Image("placeholder"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding()
                    .foregroundStyle(propertyColor)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(propertyName)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .bold()
                    
                    Spacer()
                    
                    Text(propertyType)
                        .font(.title2)
                        .foregroundStyle(.black)
                        .bold()
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(propertyAddressLine_1)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .bold()
                        Text(propertyAddressLine_2)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                .frame(maxHeight: 120, alignment: .leading)
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    MainRow(
        propertyImage: Image(systemName: "house"),
        propertyName: "W-WW-WW0/00",
        propertyType: "Mieszkanie",
        propertyAddressLine_1: "Cudowna 7/99",
        propertyAddressLine_2: "05-500 Piaseczno",
        propertyColor: Color.green
    )
}
