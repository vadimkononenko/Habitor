//
//  HabitViewModel.swift
//  Habitor
//
//  Created by Vadim Kononenko on 01.07.2025.
//

import Foundation
import CoreData
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let coreDataManager: CoreDataManager
    
    var habitsCount: Int {
        return habits.count
    }
    
    var revardedEnergy: Int {
        var revardedEnergy = 0
        
        habits.forEach { habit in
            guard let entries = habit.entries else { return }
            
            let todayEntry = entries.filter({ $0.date == Date() })
            revardedEnergy += Int(todayEntry.first?.energyEarned ?? 0)
        }
        
        return revardedEnergy
    }
    
    var completedHabitsCount: Int {
        var completedHabitsCount = 0
        habits.forEach { habit in
            guard let entries = habit.entries else { return }
            
            if entries.filter({ $0.date == Date() }).count > 0 {
                completedHabitsCount += 1
            }
        }
        
        return completedHabitsCount
    }
    
    var percentComplete: Int {
        var entriesCount = 0
        habits.forEach { habit in
            guard
                let entries = habit.entries,
                entries.contains(where: { $0.date == Date() })
            else { return }
            
            entriesCount += 1
        }
        
        return habitsCount == 0 ? 0 : (entriesCount / habits.count) * 100
    }
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchHabits() {
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        
        do {
            habits = try coreDataManager.viewContext.fetch(request)
        } catch {
            print("Fetching Error: \(error)")
        }
    }
    
    // MARK: - Habit
    
    func createHabit(title: String,
                     descriptionText: String,
                     targetDays: [Int] = [1,2,3,4,5,6,7],
                     category: Category? = nil) {
        let habit = Habit(context: coreDataManager.viewContext)
        
        habit.id = UUID()
        habit.title = title
        habit.descriptionText = descriptionText
        habit.targetDays = targetDays
        habit.bestStreak = 0
        habit.currentStreak = 0
        habit.isActive = true
        habit.energyReward = 5
        habit.totalCompletions = 0
        habit.createdAt = Date()
        habit.updatedAt = Date()
        
        if let category = category {
            habit.addToCategories(category)
        }
        
        coreDataManager.save()
        
        fetchHabits()
    }
    
    // MARK: - HabitEntry
    
    func createHabitEntry() {
        //TODO: finish creation of habit entry
    }
    
    // MARK: - Category
    
    func createCategory(name: String, color: Color) {
        let category = Category(context: coreDataManager.viewContext)
        
        category.id = UUID()
        category.name = name
        category.colorHex = color.toHex()
        category.createdAt = Date()
        
        coreDataManager.save()
    }
}
