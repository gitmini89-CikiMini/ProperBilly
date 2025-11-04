//
//  AddPropertyView.swift
//  ProperBilly
//
//  Created by Mi Ni on 04/11/2025.
//

import SwiftUI

struct AddPropertyView: View {
    @Environment(\.dismiss) private var dismiss

    let propertyImage: Image?
    @State private var  propertyName = ""
    @State private var propertyType = "Mieszkanie"
    @State private var propertyAddressStreet = ""
    @State private var  propertyAddressHouseNumber = ""
    @State private var  propertyAddressFlatNumber = ""
    @State private var  propertyAddressPostalCode = ""
    @State private var  propertyAddressCity = ""
    
    let propertyTypes = ["Dom", "Mieszkanie", "Garaż", "Komórka lokatorska"]
    
    // Colors
    @State private var propertyColor = Color.orange
    private let propertyColors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink]
    
    @State private var propertySymbol = "house.fill"
    private let propertySymbols = ["house.fill", "house.lodge.fill", "door.right.hand.closed", "sofa.fill", "door.garage.closed", "car.side.fill"]
    
    var body: some View {
        Form {
            Picker("Rodzaj nieruchomości", selection: $propertyType) {
                ForEach(propertyTypes, id: \.self) {
                    Text($0)
                }
            }
            
            Section("Dane adresowe") {
                TextField("Ulica", text: $propertyAddressStreet)
                
                HStack {
                    TextField("Nr domu", text: $propertyAddressHouseNumber)
                    TextField("Nr mieszkania", text: $propertyAddressFlatNumber)
                }
                
                TextField("Kod pocztowy", text: $propertyAddressPostalCode)
                TextField("Miejscowość", text: $propertyAddressCity)
            }
            
            TextField("Nazwa nieruchomości", text: $propertyName)
            
            // Picker of symbol
            Section("Symbol") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(propertySymbols, id: \.self) { symbol in
                            Button {
                                propertySymbol = symbol
                            } label: {
                                Image(systemName: symbol)
                                    .font(.title)
                                    .foregroundStyle(propertyColor)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(symbol == propertySymbol ? 0.9 : 0.0),
                                                lineWidth: symbol == propertySymbol ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(symbol == propertySymbol ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                }
                
                // Picker of color
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(propertyColors, id: \.self) { color in
                            Button {
                                propertyColor = color
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(color == propertyColor ? 0.9 : 0.2),
                                                lineWidth: color == propertyColor ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(color == propertyColor ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .scrollBounceBehavior(.basedOnSize)
                
                
            }
            
                
        
        }
        .navigationTitle("Dodaj nieruchomość")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Zapisz") {
                    // Some code
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPropertyView(
            propertyImage: Image(systemName: "house")
        )
    }
}
