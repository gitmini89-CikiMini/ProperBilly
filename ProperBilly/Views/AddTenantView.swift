//
//  AddTenantView.swift
//  ProperBilly
//
//  Created by Mi Ni on 06/11/2025.
//

import SwiftUI

struct AddTenantView: View {
    @Environment(\.dismiss) private var dismiss
    //@Environment(\.modelContext) private var modelContext
    
    @Bindable var tvm: AddTenantViewModel
    
    // Closure, która zwróci utworzonego najemcę do widoku nadrzędnego
    var onSave: (Tenant) -> Void = { _ in }
    
    var body: some View {
        Form {
            Section() {
                HStack {
                    TextField("Imię", text: $tvm.firstName)
                    TextField("Drugie imię", text: $tvm.secondName)
                }
                TextField("Nazwisko", text: $tvm.lastName)
                TextField("Tel. kontaktowy", text: $tvm.phoneNumber)
            }
        }
        .navigationTitle("Dodaj najemcę")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Zapisz") {
                    // Tworzymy obiekt Tenant i przekazujemy do rodzica
                    let tenant = tvm.makeTenant()
                    onSave(tenant)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddTenantView(tvm: AddTenantViewModel())
    }
}

