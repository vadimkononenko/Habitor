//
//  CompletionButton.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct CompletionButton: View {
    let isCompleted: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(strokeColor)
                    .fill(fillColor)
                        
                Image(systemName: iconName)
                    .fontWeight(.medium)
                    .foregroundColor(iconColor)
                    .scaleEffect(isCompleted ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3), value: isCompleted)
            }
        }
        .frame(width: 44, height: 44)
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Computed Properties
    private var strokeColor: Color {
        isCompleted ? .green : .gray.opacity(0.5)
    }
    
    private var fillColor: Color {
        isCompleted ? .green.opacity(0.1) : .white
    }
    
    private var iconName: String {
        isCompleted ? "checkmark.circle.fill" : "circle"
    }
    
    private var iconColor: Color {
        isCompleted ? .green : .gray
    }
}
