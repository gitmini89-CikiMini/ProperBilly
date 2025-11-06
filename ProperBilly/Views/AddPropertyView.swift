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
    
    @Bindable var vm: AddPropertyViewModel

    var body: some View {
        Form {
            Picker("Rodzaj nieruchomości", selection: $vm.propertyType) {
                ForEach(vm.propertyTypes, id: \.self) {
                    Text($0)
                }
            }
            
            Section("Dane adresowe") {
                TextField("Ulica", text: $vm.propertyAddressStreet)
                
                HStack {
                    TextField("Nr domu", text: $vm.propertyAddressHouseNumber)
                    TextField("Nr mieszkania", text: $vm.propertyAddressFlatNumber)
                }
                
                TextField("Kod pocztowy", text: $vm.propertyAddressPostalCode)
                TextField("Miejscowość", text: $vm.propertyAddressCity)
            }
            
            TextField("Nazwa nieruchomości", text: $vm.propertyName)
            
            // Picker symbolu
            Section("Symbol") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(vm.propertySymbols, id: \.self) { symbol in
                            Button {
                                vm.selectSymbol(symbol)
                            } label: {
                                Image(systemName: symbol)
                                    .font(.title)
                                    .foregroundStyle(vm.selectedColor.color)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(symbol == vm.propertySymbolName ? 0.9 : 0.0),
                                                lineWidth: symbol == vm.propertySymbolName ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(symbol == vm.propertySymbolName ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                // Picker koloru
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(vm.colors, id: \.self) { color in
                            Button {
                                vm.selectColor(color)
                            } label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(color.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(
                                                Color.primary.opacity(vm.selectedColor == color ? 0.9 : 0.2),
                                                lineWidth: vm.selectedColor == color ? 3 : 1
                                            )
                                    )
                                    .shadow(color: Color.black.opacity(vm.selectedColor == color ? 0.2 : 0.0), radius: 4, x: 0, y: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .scrollBounceBehavior(.basedOnSize)
            }
        }
        .onAppear {
            vm.onAppear()
        }
        .navigationTitle("Dodaj nieruchomość")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Zapisz") {
                    vm.save(in: modelContext)
                    dismiss()
                }
                .disabled(vm.isSaveDisabled)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddPropertyView(vm: AddPropertyViewModel())
    }
}
