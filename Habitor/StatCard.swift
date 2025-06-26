//
//  StatCard.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    
    init(title: String, value: String, subtitle: String = "") {
        self.title = title
        self.value = value
        self.subtitle = subtitle
    }
        
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    StatCard(title: "Выполнено", value: "60%", subtitle: "дней")
}
