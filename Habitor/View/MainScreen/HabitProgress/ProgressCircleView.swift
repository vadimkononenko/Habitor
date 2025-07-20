//
//  ProgressCircleView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 08.07.2025.
//

import SwiftUI

struct ProgressCircleView: View {
    var progress: Int
    
    private let size: CGFloat = 80
    
    var body: some View {
        ZStack {
            createTemplateCircle()
                        
            createCoverCircle()
                        
            createPercentText()
        }
    }
}

extension ProgressCircleView {
    @ViewBuilder
    private func createTemplateCircle() -> some View {
        Circle()
            .stroke(
                Color.gray.opacity(0.2),
                lineWidth: 8
            )
            .frame(width: size, height: size)
    }
    
    @ViewBuilder
    private func createCoverCircle() -> some View {
        Circle()
            .trim(from: 0, to: CGFloat(progress) / 100.0)
            .stroke(
                Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)),
                style: StrokeStyle(
                    lineWidth: 8,
                    lineCap: .round
                )
            )
            .frame(width: size, height: size)
            .rotationEffect(
                .degrees(-90)
            )
    }
    
    @ViewBuilder
    private func createPercentText() -> some View {
        Text("\(progress)%")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(Color.gray)
    }
}

#Preview {
    ProgressCircleView(progress: 15)
}
