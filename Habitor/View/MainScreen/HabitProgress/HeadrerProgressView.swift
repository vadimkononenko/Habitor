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
    var energyCount: Int
    var revardedEnergyCount: Int
    var completedHabitsCount: Int
    var progress: Int
    
    // MARK: - Init
    
    init(habitsCount: Int,
         energyCount: Int,
         completedHabitsCount: Int,
         revardedEnergyCount: Int,
         progress: Int) {
        self.habitsCount = habitsCount
        self.energyCount = energyCount
        self.completedHabitsCount = completedHabitsCount
        self.revardedEnergyCount = revardedEnergyCount
        self.progress = progress
    }
    
    // MARK: - Body View
    
    var body: some View {
        HStack(alignment: .top, spacing: 60) {
            HStack {
                ParamProgressView(allCount: habitsCount,
                                  currentCompletedCount: completedHabitsCount,
                                  title: "Habits")
                .frame(width: 60)
                ParamProgressView(allCount: energyCount,
                                  currentCompletedCount: revardedEnergyCount,
                                  title: "Energy")
                .frame(width: 60)
            }
            .padding(.top)
            
            ProgressCircleView(progress: progress)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HeadrerProgressView(habitsCount: 5, energyCount: 10, completedHabitsCount: 3, revardedEnergyCount: 5, progress: 60)
}
