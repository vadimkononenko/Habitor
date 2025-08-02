//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

struct HabitCardView: View {

    @EnvironmentObject private var habitViewModel: HabitViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: - Properties
    @StateObject private var viewModel: HabitCardViewModel
    let habit: Habit
    
    // MARK: - Init
    init (habit: Habit) {
        self.habit = habit
        _viewModel = StateObject(
            wrappedValue: HabitCardViewModel(habit: habit,
                                             habitViewModel: HabitViewModel(coreDataManager: CoreDataManager.shared))
        )
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            HabitCardHeaderView(habit: habit,
                                isCompleted: viewModel.isCompletedToday) {
                handleCompletionToday()
            }
            
            HabitCardFooterView(habit: habit)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        )
        .onReceive(
            NotificationCenter.default
                .publisher(for: .NSManagedObjectContextDidSave)
        ) { _ in
            ///Updating data when Core Data changes
            viewModel.refreshData()
        }
    }
    
    // MARK: - Actions
    private func handleCompletionToday() {
        withAnimation(.spring(response: 0.3)) {
            viewModel.handleCompletionToday()
        }
    }
}
