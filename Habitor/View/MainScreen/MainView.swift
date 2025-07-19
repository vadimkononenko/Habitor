//
//  MainView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: HabitViewModel
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Habit.createdAt, ascending: false)
        ],
        predicate: NSPredicate(format: "isActive == %@", NSNumber(value: true)),
        animation: .default
    ) private var habits: FetchedResults<Habit>
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            VStack {
                HeadrerProgressView(habitsCount: habits.count,
                                    energyCount: totalEnergyCount,
                                    completedHabitsCount: completedHabitsCount,
                                    revardedEnergyCount: revardedEnergy,
                                    progress: percentComplete)
                .padding()
                
                ForEach(habits, id: \.self) { habit in
                    HabitCardView(habit: habit)
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Computed Properties For Statistic
extension MainView {
    private var totalEnergyCount: Int {
        Int(habits.reduce(0) { $0 + $1.energyReward })
    }
    
    private var completedHabitsCount: Int {
        let today = Calendar.current.startOfDay(for: Date())
        
        let completedHabits = habits.filter { habit in
            guard let entries = habit.entries else { return false }
            
            return entries.contains { entry in
                guard let entryDate = entry.date else { return false }
                return Calendar.current.isDate(entryDate, inSameDayAs: today)
            }
        }
        
        return completedHabits.count
    }
    
    private var revardedEnergy: Int {
        let today = Calendar.current.startOfDay(for: Date())
                
        return habits.reduce(0) { total, habit in
            guard let entries = habit.entries else { return total }
                    
            let todayEntry = entries.first { entry in
                guard let entryDate = entry.date else { return false }
                return Calendar.current.isDate(entryDate, inSameDayAs: today)
            }
                    
            return total + Int(todayEntry?.energyEarned ?? 0)
        }
    }
    
    private var percentComplete: Int {
        guard habits.count > 0 else { return 0 }
        
        return Int((Double(completedHabitsCount) / Double(habits.count)) * 100)
    }
}

#Preview {
    MainView()
        .environmentObject(
            HabitViewModel(coreDataManager: CoreDataManager.shared)
        )
}
