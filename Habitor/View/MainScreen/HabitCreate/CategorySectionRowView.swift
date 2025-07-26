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
            Circle()
                .fill(category.color)
                .frame(width: 20, height: 20)
            
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
