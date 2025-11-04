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
        ZStack {
            propertyColor
                .frame(height: 156)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
            
            HStack(alignment: .center, spacing: 10) {
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
                    .padding(13)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(propertyName)
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    Text(propertyType)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Spacer()
                    
                    Text(propertyAddressLine_1)
                        .font(.subheadline)
                        .bold()
                    Text(propertyAddressLine_2)
                        .font(.subheadline)
                        .bold()
                }
                .frame(maxWidth: .infinity, maxHeight: 120, alignment: .leading)
               // .padding()
            }
            .padding()
        }
    }
}

#Preview {
    MainRow(
        propertyImage: Image(systemName: "house"),
        propertyName: "M-PIA-CUD7/99",
        propertyType: "Mieszkanie",
        propertyAddressLine_1: "Cudowna 7/99",
        propertyAddressLine_2: "05-500 Piaseczno",
        propertyColor: Color.green
    )
}
