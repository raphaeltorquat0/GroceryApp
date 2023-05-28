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
        VStack {
            if model.groceryCategories.isEmpty {
                HStack {
                    VStack {
                        Text("No grocery categories found.")
                    }
                }
            } else {
                List {
                    ForEach(model.groceryCategories) { groceryCategory in
                        NavigationLink(value: Route.groceryCategoryDetail(groceryCategory)) {
                            HStack {
                                Circle()
                                    .fill(Color.fromHex(groceryCategory.colorCode))
                                    .frame(width: 25, height: 25)
                                Text("A")
                            }
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


struct GroceryCategoryListScreenContainerView: View {
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            GroceryCategoryListScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .register:
                        RegistrationScreen()
                    case .login:
                        LoginScreen()
                    case .groceryCategoryList:
                        Text("Grocery Category List")
                    case .groceryCategoryDetail(let groceryCategory):
                        GroceryDetailScreen(groceryCategory: groceryCategory)
                    }
                }
        }
        .environmentObject(model)
        .environmentObject(appState)
    }
}


struct GroceryCategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        GroceryCategoryListScreenContainerView()
    }
}
