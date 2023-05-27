//
//  GroceryCategoryListScreen.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 25/05/23.
//

import SwiftUI

struct GroceryCategoryListScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @State private var isPresented: Bool = false
    
    private func fetchGroceryCategories() async {
        do {
            try await model.populateGroceryCategories()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteGroceryCategory(at offSets: IndexSet)  {
        offSets.forEach { index in
            let groceryCategory = model.groceryCategories[index]
            Task {
                do {
                    try await model.deleteGroceryCategoryBy(groceryCategory.id)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
       
    var body: some View {
        
        ZStack {
            if model.groceryCategories.isEmpty {
                HStack {
                    VStack {
                        Text("No grocery categories found.")
                    }
                }
            } else {
                
                
                
                List {
                    ForEach(model.groceryCategories) { groceryCategory in
                        HStack {
                            Circle()
                                .fill(Color.fromHex(groceryCategory.colorCode))
                                .frame(width: 25, height: 25)
                            Text("A")
                        }
                    }.onDelete(perform: deleteGroceryCategory)
                }
            }
        }
      
        .task {
            await fetchGroceryCategories()
        }
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Logout") {
                    
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $isPresented) {
            NavigationStack {
                AddGroceryCategoryScreen()
            }
        }
    }
}

struct GroceryCategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryCategoryListScreen()
                .environmentObject(GroceryModel())
        }
    }
}
