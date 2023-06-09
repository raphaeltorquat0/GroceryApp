//
//  AddGroceryCategoryScreen.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 24/05/23.
//

import Foundation
import SwiftUI
import GroceryAppSharedDTO

struct AddGroceryCategoryScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    
    @State private var title: String = ""
    @State private var colorCode: String = "#2ecc71"
    
    @Environment(\.dismiss) private var dismiss
    
    private func saveGroceryCategory() async {
        let groceryCategoryRequestDTO = GroceryCategoryRequestDTO(title: title, colorCode: colorCode)
        do {
            try await model.saveGroceryCategory(groceryCategoryRequestDTO)
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            ColorSelector(colorCode: $colorCode)
        }.navigationTitle("New Category")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            await saveGroceryCategory()
                        }
                    }.disabled(!isFormValid)
                }
        }
    }
}

struct AddGroceryCAtegoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryCategoryScreen().environmentObject(GroceryModel())
        }
    }
}
