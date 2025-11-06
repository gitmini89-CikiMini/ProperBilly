// AddPropertyViewModel.swift
import Foundation
import SwiftUI
import SwiftData
import Observation

@MainActor
@Observable
final class AddPropertyViewModel {
    // Form state
    var propertyName = ""
    var propertyType = "Mieszkanie"
    var propertyAddressStreet = ""
    var propertyAddressHouseNumber = ""
    var propertyAddressFlatNumber = ""
    var propertyAddressPostalCode = ""
    var propertyAddressCity = ""
    
    // Types
    let propertyTypes = ["Dom", "Mieszkanie", "Garaż", "Komórka lokatorska"]
    
    // Color
    var propertyColorName = "orange"
    var selectedColor: PropertyColor = .orange
    let colors: [PropertyColor] = PropertyColor.allCases
    
    // Symbol
    var propertySymbolName = "house.fill"
    let propertySymbols = ["house.fill", "house.lodge.fill", "door.right.hand.closed", "sofa.fill", "door.garage.closed", "car.side.fill"]
    
    var isSaveDisabled: Bool {
        propertyName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func onAppear() {
        if let initial = PropertyColor(rawValue: propertyColorName) {
            selectedColor = initial
        } else {
            selectedColor = .orange
            propertyColorName = selectedColor.rawValue
        }
    }
    
    func selectColor(_ color: PropertyColor) {
        selectedColor = color
        propertyColorName = color.rawValue
    }
    
    func selectSymbol(_ symbol: String) {
        propertySymbolName = symbol
    }
    
    func save(in context: ModelContext) {
        let newProperty = Property(
            propertyName: propertyName,
            propertyType: propertyType,
            propertyAddressStreet: propertyAddressStreet,
            propertyAddressHouseNumber: propertyAddressHouseNumber,
            propertyAddressFlatNumber: propertyAddressFlatNumber,
            propertyAddressPostalCode: propertyAddressPostalCode,
            propertyAddressCity: propertyAddressCity,
            propertyColorName: selectedColor.rawValue,
            propertySymbolName: propertySymbolName
        )
        context.insert(newProperty)
        try? context.save()
    }
}
