//
//  MainView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            VStack {
                HeadrerProgressView(habitsCount: viewModel.habitsCount,
                                    completedHabitsCount: viewModel.completedHabitsCount,
                                    revardedEnergyCount: viewModel.revardedEnergy,
                                    progress: viewModel.percentComplete)
                .padding()
                
                ForEach(viewModel.habits, id: \.self) { habit in
                    HabitCardView(habit: habit)
                }
                .padding(.horizontal)
            }
            .onAppear {
                viewModel.fetchHabits()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(
            HabitViewModel(coreDataManager: CoreDataManager.shared)
        )
}
