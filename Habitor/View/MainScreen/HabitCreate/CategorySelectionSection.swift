//
//  CategorySelectionSection.swift
//  Habitor
//
//  Created by Vadim Kononenko on 21.07.2025.
//

import SwiftUI
import CoreData

struct CategorySelectionSection: View {
    let categories: [Category]
    @Binding var selectedCategoryIDs: [NSManagedObjectID]
        
    var body: some View {
        Section("Categories") {
            if categories.isEmpty {
                Text("No categories available")
                    .foregroundColor(.secondary)
                    .font(.caption)
            } else {
                ForEach(categories, id: \.objectID) { category in
                    CategorySectionRowView(
                        category: category,
                        isSelected: selectedCategoryIDs.contains(category.objectID)
                    ) {
                        toggleCategorySelection(category)
                    }
                }
            }
        }
    }
    
    private func toggleCategorySelection(_ category: Category) {
        if let index = selectedCategoryIDs.firstIndex(of: category.objectID) {
            selectedCategoryIDs.remove(at: index)
        } else {
            selectedCategoryIDs.append(category.objectID)
        }
    }
}
