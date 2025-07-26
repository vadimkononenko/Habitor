//
//  CategoriesScrollView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct CategoriesScrollView: View {
    let categories: [Category]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(categories), id: \.id) { category in
                    CategoryTagView(category: category)
                }
            }
        }
    }
}

// MARK: - CategoryTagView
struct CategoryTagView: View {
    let category: Category

    var body: some View {
        Text(category.name ?? "")
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .background(categoryColor.opacity(0.2))
            .foregroundColor(categoryColor)
            .cornerRadius(8)
            .font(.caption2)
    }

    private var categoryColor: Color {
        Color(hex: category.colorHex ?? "007AFF") ?? .blue
    }
}
