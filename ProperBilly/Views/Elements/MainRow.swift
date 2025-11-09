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
    let tenants: [Tenant]
    
    let propertyColor: Color
    
    private var tenantFirstNames: String {
        tenants.map { $0.firstName }.joined(separator: ", ")
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            propertyColor
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
            
            HStack(spacing: -10) {
                (propertyImage ?? Image("placeholder"))
                    .resizable()
                    .scaledToFit()
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
                    
                    // Imiona najemców (jeśli są)
                    if !tenants.isEmpty {
                        Text(tenantFirstNames)
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.8))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
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
        tenants: [
            Tenant(firstName: "Anna", secondName: "Basia", lastName: "Kowalska", phoneNumber: "123456789"),
            Tenant(firstName: "Piotr", secondName: "Janek", lastName: "Nowak", phoneNumber: "987654321")
        ],
        propertyColor: Color.green
    )
}
