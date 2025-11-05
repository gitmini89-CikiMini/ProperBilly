//
//  Data.swift
//  ProperBilly
//
//  Created by Mi Ni on 04/11/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Property {
    var propertyName: String
    var propertyType: String
    var propertyAddressStreet: String
    var propertyAddressHouseNumber: String
    var propertyAddressFlatNumber: String
    var propertyAddressPostalCode: String
    var propertyAddressCity: String
    var propertyColor: PropertyColor
    var propertySymbol: String

    var color: Color {
        propertyColor.color
    }
    
    init(
        propertyName: String,
        propertyType: String,
        propertyAddressStreet: String,
        propertyAddressHouseNumber: String,
        propertyAddressFlatNumber: String,
        propertyAddressPostalCode: String,
        propertyAddressCity: String,
        propertyColor: PropertyColor,
        propertySymbol: String
    ) {
        self.propertyName = propertyName
        self.propertyType = propertyType
        self.propertyAddressStreet = propertyAddressStreet
        self.propertyAddressHouseNumber = propertyAddressHouseNumber
        self.propertyAddressFlatNumber = propertyAddressFlatNumber
        self.propertyAddressPostalCode = propertyAddressPostalCode
        self.propertyAddressCity = propertyAddressCity
        self.propertyColor = propertyColor
        self.propertySymbol = propertySymbol
    }
}

enum PropertyColor: String, CaseIterable, Hashable, Codable {
    case red, orange, yellow, green, blue, indigo, purple, pink
    
    var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .indigo: return .indigo
        case .purple: return .purple
        case .pink: return .pink
        }
    }
}

