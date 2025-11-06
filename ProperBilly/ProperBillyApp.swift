//
//  ProperBillyApp.swift
//  ProperBilly
//
//  Created by Mi Ni on 29/10/2025.
//

import SwiftUI
import SwiftData

@main
struct ProperBillyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Property.self)
    }
}

