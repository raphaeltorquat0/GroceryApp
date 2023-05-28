//
//  GroceryItemListView.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 27/05/23.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryItemListView: View {
    
    let groceryItems: [GroceryItemResponseDTO]
    
    var body: some View {
        List {
            ForEach(groceryItems) { groceryItem in
                Text(groceryItem.title)
            }
        }
    }
}

struct GroceryItemListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemListView(groceryItems: [])
    }
}
