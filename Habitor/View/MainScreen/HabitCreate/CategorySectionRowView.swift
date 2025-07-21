//
//  CategorySectionRowView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 21.07.2025.
//

import SwiftUI

struct CategorySectionRowView: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
        
    var body: some View {
        HStack {
            Text(category.name ?? "Untitled")
                
            Spacer()
                
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}
