//
//  PropertyView.swift
//  ProperBilly
//
//  Created by Mi Ni on 09/11/2025.
//

import SwiftUI

struct PropertyView: View {
    let property: Property
    let mvm = MainViewModel()
    
    private var tenantNames: [String] {
        property.tenants.map { $0.firstName + " " + $0.lastName }
    }
    
    private var tenantPhoneNumber: [String] {
        property.tenants.map { $0.phoneNumber }
    }
    
    private var color: Color {
        PropertyColor(rawValue: property.propertyColorName)?.color ?? .orange
    }
    
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            
            List {
                Section {
                    HStack(spacing: 15) {
                        Image(systemName: property.propertySymbolName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(color)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(property.propertyType)
                                .font(.title2)
                                //.foregroundStyle(.black)
                                .bold()
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(mvm.addressLine1(for: property))
                                    .font(.subheadline)
                                    //.foregroundStyle(.black)
                                    .bold()
                                Text(mvm.addressLine2(for: property))
                                    .font(.subheadline)
                                    //.foregroundStyle(.black)
                                    .bold()
                            }
                        }
                        .padding()
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
                        if property.tenants.isEmpty {
                            ContentUnavailableView("Brak dodanych najemców", systemImage: "person.2.slash")
                        } else {
                            ForEach(property.tenants, id: \.self) { tenant in
                                DisclosureGroup {
                                    HStack {
                                        Image(systemName: "phone.fill")
                                        Text(tenant.phoneNumber)
                                            .font(.subheadline)
                                    }
                                } label: {
                                    Text(tenant.firstName + " " + tenant.lastName)
                                        .font(.subheadline)
                                        .bold()
                                        //.foregroundStyle(.black.opacity(0.8))
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .padding(.vertical, 5)
                                }
                                
                            }
                        }
                    }
                } header: {
                    Text("Najemcy")
                        .foregroundStyle(.black)
                }
                .listSectionSeparator(.hidden)
            }
            //.listStyle(.insetGrouped)
            //.scrollContentBackground(.hidden) // ukrywa domyślne tło listy, żeby było widać Color
        }
        .navigationTitle(property.propertyName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let previewProperty = Property(
        propertyName: "W-WW-WW0/00",
        propertyType: "Mieszkanie",
        propertyAddressStreet: "Cudowna",
        propertyAddressHouseNumber: "7",
        propertyAddressFlatNumber: "99",
        propertyAddressPostalCode: "05-500",
        propertyAddressCity: "Piaseczno",
        propertyColorName: "green",
        propertySymbolName: "house"
    )
    
    let tenant1 = Tenant(firstName: "Anna", secondName: "Basia", lastName: "Kowalska", phoneNumber: "+48 123 456 789")
    let tenant2 = Tenant(firstName: "Piotr", secondName: "Jan", lastName: "Nowak", phoneNumber: "987 654 321")
   
    tenant1.property = previewProperty
    tenant2.property = previewProperty
    previewProperty.tenants = [tenant1, tenant2]
    
    return NavigationStack {
        PropertyView(property: previewProperty)
    }
}
