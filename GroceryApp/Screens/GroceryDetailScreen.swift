//
//  GroceryDetailScreen.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 26/05/23.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryDetailScreen: View {
    
    let groceryCategory: GroceryCategoryResponseDTO
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    private func populateGroceryItems() async {
        do {
            try await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            if model.groceryItems.isEmpty {
                Text("No items found")
            } else {
              GroceryItemListView(groceryItems: model.groceryItems)
            }
        }.navigationTitle(groceryCategory.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add grocery Item") {
                        isPresented = true
                    }
                }
            }.sheet(isPresented: $isPresented) {
                NavigationStack {
                    AddGroceryItemScreen()
                }
            }
            .onAppear {
                model.groceryCategory = groceryCategory
            }.task {
                await populateGroceryItems()
            }
    }
}

struct GroceryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(uuidString: "dcfa5777-81b0-471c-b24e-5485063a5db9")!, title: "Beverages", colorCode: "#3498db"))
                .environmentObject(GroceryModel())
        }
    }
}


