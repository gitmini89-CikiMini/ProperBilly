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
    var propertyColorName: String
    var propertySymbolName: String
    @Relationship(deleteRule: .cascade) var tenants: [Tenant] = []
    
    init(
        propertyName: String,
        propertyType: String,
        propertyAddressStreet: String,
        propertyAddressHouseNumber: String,
        propertyAddressFlatNumber: String,
        propertyAddressPostalCode: String,
        propertyAddressCity: String,
        propertyColorName: String,
        propertySymbolName: String
    ) {
        self.propertyName = propertyName
        self.propertyType = propertyType
        self.propertyAddressStreet = propertyAddressStreet
        self.propertyAddressHouseNumber = propertyAddressHouseNumber
        self.propertyAddressFlatNumber = propertyAddressFlatNumber
        self.propertyAddressPostalCode = propertyAddressPostalCode
        self.propertyAddressCity = propertyAddressCity
        self.propertyColorName = propertyColorName
        self.propertySymbolName = propertySymbolName
    }
}

@Model
class Tenant {
    var property: Property?
    var firstName: String
    var secondName: String
    var lastName: String
    var phoneNumber: String
    
    init(property: Property? = nil, firstName: String, secondName: String, lastName: String, phoneNumber: String) {
        self.property = property
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
