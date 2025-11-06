// MainViewModel.swift
import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class MainViewModel {
    func addressLine1(for property: Property) -> String {
        let flat = property.propertyAddressFlatNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        let flatPart = flat.isEmpty ? "" : "/\(flat)"
        return "\(property.propertyAddressStreet) \(property.propertyAddressHouseNumber)\(flatPart)"
    }
    
    func addressLine2(for property: Property) -> String {
        "\(property.propertyAddressPostalCode) \(property.propertyAddressCity)"
    }
    
    func delete(at offsets: IndexSet, from properties: [Property], in context: ModelContext) {
        for index in offsets {
            context.delete(properties[index])
        }
        try? context.save()
    }
}
