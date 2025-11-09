//
//  MainView.swift
//  ProperBilly
//
//  Created by Mi Ni on 04/11/2025.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Property.propertyType) private var properties: [Property]
    
    @State private var mvm = MainViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(properties) { property in
                    NavigationLink {
                        PropertyView(property: property)
                    } label: {
                        MainRow(
                            propertyImage: Image(systemName: property.propertySymbolName),
                            propertyName: property.propertyName,
                            propertyType: property.propertyType,
                            propertyAddressLine_1: mvm.addressLine1(for: property),
                            propertyAddressLine_2: mvm.addressLine2(for: property),
                            tenants: property.tenants,
                            propertyColor: PropertyColor(rawValue: property.propertyColorName)?.color ?? .orange
                        )
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .onDelete { offsets in
                    mvm.delete(at: offsets, from: properties, in: modelContext)
                }
            }
            .listStyle(.plain)
            .navigationTitle("ProperBilly")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink {
                        AddPropertyView(pvm: AddPropertyViewModel())
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Button {
                        // Add action here
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Property.self, configurations: config)
        return MainView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
    
    
}
