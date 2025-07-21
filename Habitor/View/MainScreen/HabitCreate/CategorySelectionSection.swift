//
//  CategorySelectionSection.swift
//  Habitor
//
//  Created by Vadim Kononenko on 21.07.2025.
//

import SwiftUI

struct CategorySelectionSection: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?
        
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
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = selectedCategory == category ? nil : category
                    }
                }
            }
        }
    }
}
