//
//  ParamProgressView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 20.06.2025.
//

import SwiftUI

struct ParamProgressView: View {
    
    var allCount: Int
    var currentCompletedCount: Int
    var title: String
    
    var formattedCountText: String {
        "\(currentCompletedCount) / \(allCount)"
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Group {
                Text("\(currentCompletedCount)")
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)))
                    .font(.title2)
                    .fontWeight(.heavy)
                + Text(" / ")
                + Text("\(allCount)")
            }
            .font(.subheadline)
            
            Text(title)
                .font(.caption)
                .fontWeight(.light)
        }
    }
}

#Preview {
    ParamProgressView(allCount: 20,
                      currentCompletedCount: 5,
                      title: "Energy")
}
