//
//  AddPropertyView.swift
//  ProperBilly
//
//  Created by Mi Ni on 04/11/2025.
//
import SwiftData
import SwiftUI

struct AddPropertyView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    //let propertyImage: Image?
    @State private var propertyName = ""
    @State private var propertyType = "Mieszkanie"
    @State private var propertyAddressStreet = ""
    @State private var propertyAddressHouseNumber = ""
    @State private var propertyAddressFlatNumber = ""
    @State private var propertyAddressPostalCode = ""
    @State private var propertyAddressCity = ""
    
    let propertyTypes = ["Dom", "Mieszkanie", "Garaż", "Komórka lokatorska"]
    
    // Colors
    @State private var colorSelection: PropertyColor = .orange
    private var propertyColor: Color { colorSelection.color }
    
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
            
            // Picker symbolu
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
                
                // Picker koloru
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(PropertyColor.allCases, id: \.self) { colorCase in
                            Button {
                                colorSelection = colorCase
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(colorCase.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(colorCase == colorSelection ? 0.9 : 0.2),
                                                lineWidth: colorCase == colorSelection ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(colorCase == colorSelection ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
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
                    let newProperty = Property(
                        propertyName: propertyName,
                        propertyType: propertyType,
                        propertyAddressStreet: propertyAddressStreet,
                        propertyAddressHouseNumber: propertyAddressHouseNumber,
                        propertyAddressFlatNumber: propertyAddressFlatNumber,
                        propertyAddressPostalCode: propertyAddressPostalCode,
                        propertyAddressCity: propertyAddressCity,
                        propertyColor: colorSelection,
                        propertySymbol: propertySymbol
                    )
                    modelContext.insert(newProperty)
                    // try? modelContext.save()
                    dismiss()
                }
                .disabled(propertyName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPropertyView()
    }
}

