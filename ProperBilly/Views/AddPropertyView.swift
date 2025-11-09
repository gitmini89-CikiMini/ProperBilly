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
            
            Section("Symbol") {
                // Picker symbolu
                SymbolPickerView(
                    symbols: pvm.propertySymbols,
                    selectedSymbol: pvm.propertySymbolName,
                    tint: pvm.selectedColor.color,
                    onSelect: { symbol in
                        pvm.selectSymbol(symbol)
                    }
                )
                
                // Picker koloru
                ColorPickerView(
                    colors: pvm.colors,
                    selectedColor: pvm.selectedColor,
                    onSelect: { color in
                        pvm.selectColor(color)
                    }
                )
            }
            NavigationLink {
                AddTenantView(tvm: AddTenantViewModel()) { tenant in
                    pvm.tenants.append(tenant)
                }
            } label: {
                Text("Dodaj najemcę")
            }
            // Widok poszczególnych dodanych najemców.
            Section("Najemcy") {
                if pvm.tenants.isEmpty {
                    ContentUnavailableView("Brak dodanych najemców", systemImage: "person.2.slash")
                } else {
                    ForEach(pvm.tenants) { tenant in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(tenant.firstName) \(tenant.secondName) \(tenant.lastName)")
                                .font(.headline)
                            if !tenant.phoneNumber.isEmpty {
                                Text(tenant.phoneNumber)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        pvm.tenants.remove(atOffsets: indexSet)
                    }
                }
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
        
        //Albo tutaj widok najemców w List -> ForEach
    }
}

#Preview {
    NavigationStack {
        AddPropertyView(pvm: AddPropertyViewModel())
    }
}

struct SymbolPickerView: View {
    let symbols: [String]
    let selectedSymbol: String
    let tint: Color
    let onSelect: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(symbols, id: \.self) { symbol in
                    Button {
                        onSelect(symbol)
                    } label: {
                        Image(systemName: symbol)
                            .font(.title)
                            .foregroundStyle(tint)
                            .frame(width: 70, height: 70)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(
                                        Color.primary.opacity(symbol == selectedSymbol ? 0.9 : 0.0),
                                        lineWidth: symbol == selectedSymbol ? 3 : 1
                                    )
                            )
                            .shadow(color: Color.black.opacity(symbol == selectedSymbol ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct ColorPickerView: View {
    let colors: [PropertyColor]
    let selectedColor: PropertyColor
    let onSelect: (PropertyColor) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(colors, id: \.self) { color in
                    Button {
                        onSelect(color)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color.color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(
                                        Color.primary.opacity(selectedColor == color ? 0.9 : 0.2),
                                        lineWidth: selectedColor == color ? 3 : 1
                                    )
                            )
                            .shadow(color: Color.black.opacity(selectedColor == color ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 4)
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}
