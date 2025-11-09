//
//  AddTenantViewModel.swift
//  ProperBilly
//
//  Created by Mi Ni on 06/11/2025.
//

import Foundation
import SwiftData

@MainActor
@Observable
final class AddTenantViewModel {
    var firstName: String = ""
    var secondName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    
    func makeTenant() -> Tenant {
        Tenant(
            firstName: firstName,
            secondName: secondName,
            lastName: lastName,
            phoneNumber: phoneNumber
        )
    }
}

