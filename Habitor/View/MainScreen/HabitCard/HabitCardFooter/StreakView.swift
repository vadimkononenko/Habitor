//
//  StreakView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.07.2025.
//

import SwiftUI

struct StreakView: View {
    let streak: Int
    
    var body: some View {
        Text("🔥 \(streak)")
            .font(.caption)
            .foregroundColor(.orange)
    }
}
