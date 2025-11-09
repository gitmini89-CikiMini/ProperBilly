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
    
    @Bindable var pvm: AddPropertyViewModel

    var body: some View {
        Form {
            Picker("Rodzaj:", selection: $pvm.propertyType) {
                ForEach(pvm.propertyTypes, id: \.self) {
                    Text($0)
                }
            }
            
            Section("Dane adresowe") {
                TextField("Ulica", text: $pvm.propertyAddressStreet)
                
                HStack {
                    TextField("Nr domu", text: $pvm.propertyAddressHouseNumber)
                    TextField("Nr mieszkania", text: $pvm.propertyAddressFlatNumber)
                }
                
                TextField("Kod pocztowy", text: $pvm.propertyAddressPostalCode)
                TextField("Miejscowość", text: $pvm.propertyAddressCity)
            }
            
            Section("Nazwa") {
                TextField("Nazwa nieruchomości", text: $pvm.propertyName)
            }
            
            // Picker symbolu
            Section("Symbol") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(pvm.propertySymbols, id: \.self) { symbol in
                            Button {
                                pvm.selectSymbol(symbol)
                            } label: {
                                Image(systemName: symbol)
                                    .font(.title)
                                    .foregroundStyle(pvm.selectedColor.color)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(symbol == pvm.propertySymbolName ? 0.9 : 0.0),
                                                lineWidth: symbol == pvm.propertySymbolName ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(symbol == pvm.propertySymbolName ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                // Picker koloru
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(pvm.colors, id: \.self) { color in
                            Button {
                                pvm.selectColor(color)
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(pvm.selectedColor == color ? 0.9 : 0.2),
                                                lineWidth: pvm.selectedColor == color ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(pvm.selectedColor == color ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .scrollBounceBehavior(.basedOnSize)
            }
            NavigationLink {
                AddTenantView(tvm: AddTenantViewModel()) { tenant in
                    pvm.tenants.append(tenant)
                }
            } label: {
                Text("Dodaj najemcę")
            }
        }
        .onAppear {
            pvm.onAppear()
        }
        .navigationTitle("Dodaj nieruchomość")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Zapisz") {
                    pvm.save(in: modelContext)
                    dismiss()
                }
                .disabled(pvm.isSaveDisabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPropertyView(pvm: AddPropertyViewModel())
    }
}
