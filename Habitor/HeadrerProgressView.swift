//
//  HeadrerProgressView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 20.06.2025.
//

import SwiftUI

struct HeadrerProgressView: View {
    
    // MARK: - Params
    
    var allHabitsCount: Int
    var currentCompletedHabitsCount: Int
    var allEnergyCount: Int
    var currentEnergyCount: Int
    
    var progress: Double {
        Double(currentCompletedHabitsCount) / Double(allHabitsCount)
    }
    
    // MARK: - Init
    
    init(allHabitsCount: Int,
         currentCompletedHabitsCount: Int,
         allEnergyCount: Int,
         currentEnergyCount: Int) {
        self.allHabitsCount = allHabitsCount
        self.currentCompletedHabitsCount = currentCompletedHabitsCount
        self.allEnergyCount = allEnergyCount
        self.currentEnergyCount = currentEnergyCount
    }
    
    // MARK: - Body View
    
    var body: some View {
        HStack {
            VStack {
                Text("You are almost done!")
                    
                HStack(spacing: 30) {
                    ParamProgressView(allCount: allHabitsCount,
                                      currentCompletedCount: currentCompletedHabitsCount,
                                      title: "Habits")
                    
                    ParamProgressView(allCount: allEnergyCount,
                                      currentCompletedCount: currentEnergyCount,
                                      title: "Energy")
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
                                
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HeadrerProgressView(
        allHabitsCount: 5,
        currentCompletedHabitsCount: 3,
        allEnergyCount: 20,
        currentEnergyCount: 5)
}
