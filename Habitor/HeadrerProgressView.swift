//
//  HeadrerProgressView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 20.06.2025.
//

import SwiftUI

struct HeadrerProgressView: View {
    
    // MARK: - Params
    
    var habitsCount: Int
    var revardedEnergyCount: Int
    var completedHabitsCount: Int
    var progress: Int
    
    // MARK: - Init
    
    init(habitsCount: Int, completedHabitsCount: Int, revardedEnergyCount: Int, progress: Int) {
        self.habitsCount = habitsCount
        self.completedHabitsCount = completedHabitsCount
        self.revardedEnergyCount = revardedEnergyCount
        self.progress = progress
    }
    
    // MARK: - Body View
    
    var body: some View {
        HStack {
            VStack {
                Text("You are almost done!")
                    
                HStack(spacing: 30) {
                    ParamProgressView(allCount: habitsCount,
                                      currentCompletedCount: completedHabitsCount,
                                      title: "Habits")
                    
//                    ParamProgressView(allCount: allEnergyCount,
//                                      currentCompletedCount: currentEnergyCount,
//                                      title: "Energy")
                }
                .padding(.top)
            }
                
            Spacer()
                
            VStack {
                ZStack {
                    Circle()
                        .stroke(
                            Color.gray.opacity(0.2),
                            lineWidth: 8
                        )
                        .frame(width: 80, height: 80)
                                
                    Circle()
                        .trim(from: 0, to: 0.5)
                        .stroke(
                            Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)),
                            style: StrokeStyle(
                                lineWidth: 8,
                                lineCap: .round
                            )
                        )
                        .frame(width: 80, height: 80)
                        .rotationEffect(
                            .degrees(-90)
                        )
                                
                    Text("\(progress)%")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HeadrerProgressView(habitsCount: 5, completedHabitsCount: 3, revardedEnergyCount: 10, progress: 60)
}
