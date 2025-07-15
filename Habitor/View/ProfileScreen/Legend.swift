//
//  Legend.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct Legend: View {
    var body: some View {
        HStack {
            Text("Меньше")
                .font(.caption)
                .foregroundColor(.secondary)
                
            HStack(spacing: 3) {
                legendSquare(color: Color.gray.opacity(0.15))
                legendSquare(color: Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)).opacity(0.3))
                legendSquare(color: Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)).opacity(0.6))
                legendSquare(color: Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)))
            }
                
            Text("Больше")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
        
    private func legendSquare(color: Color) -> some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(color)
            .frame(width: 12, height: 12)
    }
}

#Preview {
    Legend()
}
