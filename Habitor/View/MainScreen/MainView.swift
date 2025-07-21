//
//  MainView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 01.07.2025.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case habitCreation
    case habitDetail(Habit)
}

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var viewModel: HabitViewModel
    
    @State private var navigationPath = NavigationPath()
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Habit.createdAt, ascending: false)
        ],
        predicate: NSPredicate(format: "isActive == %@", NSNumber(value: true)),
        animation: .default
    ) private var habits: FetchedResults<Habit>
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                HeadrerProgressView(habitsCount: habits.count,
                                    energyCount: totalEnergyCount,
                                    completedHabitsCount: completedHabitsCount,
                                    revardedEnergyCount: revardedEnergy,
                                    progress: percentComplete)
                .padding()
                
                ScrollView(.vertical,
                           showsIndicators: false) {
                    ForEach(habits, id: \.self) { habit in
                        HabitCardView(habit: habit)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        navigationPath.append(NavigationDestination.habitCreation)
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            
                            Text("New habit")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        )
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal)
                }
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .habitCreation:
                    HabitCreationView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(viewModel)
                                    
                case .habitDetail(let habit):
                    Text("Detail")
                }
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
