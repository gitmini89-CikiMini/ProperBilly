//
//  MainView.swift
//  ProperBilly
//
//  Created by Mi Ni on 04/11/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("ProperBilly")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink {
                        AddPropertyView(
                            propertyImage: Image(systemName: "house"),
                        )
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
    MainView()
}
