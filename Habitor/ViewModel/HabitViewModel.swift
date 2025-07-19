//
//  HabitViewModel.swift
//  Habitor
//
//  Created by Vadim Kononenko on 01.07.2025.
//

import Foundation
import CoreData
import SwiftUI

// MARK: - HabitViewModel
class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
}

// MARK: - Methods
extension HabitViewModel {
    func getHabitEntry(for habit: Habit, on date: Date) -> HabitEntry? {
        guard let entries = habit.entries else { return nil }
        
        return entries.first { entry in
            guard let entryDate = entry.date else { return false }
            return Calendar.current.isDate(entryDate, inSameDayAs: date)
        }
    }
    
    func completeHabitEntry(for habit: Habit, on date: Date) {
        let habitEntry = getHabitEntry(for: habit, on: date)
        
        guard let habitEntry else {
            createHabitEntry(for: habit, on: date)
            return
        }
        
        deleteHabitEntry(habitEntry)
    }
}

// MARK: - CoreData CRUD

extension HabitViewModel {
    
    // MARK: - Habit
    func createHabit(title: String,
                     descriptionText: String,
                     targetDays: [Int] = [1,2,3,4,5,6,7],
                     category: Category? = nil) -> Habit {
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
        
        return habit
    }
    
    func fetchHabits() {
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        
        do {
            habits = try coreDataManager.viewContext.fetch(request)
        } catch {
            print("Fetching Error: \(error)")
        }
    }
    
    // MARK: - HabitEntry
    func createHabitEntry(for habit: Habit,
                          with note: String? = nil,
                          on date: Date = Date()) {
        let habitEntry = HabitEntry(context: coreDataManager.viewContext)
        
        habitEntry.id = UUID()
        habitEntry.date = date
        habitEntry.completedAt = Date()
        habitEntry.isCompleted = true
        habitEntry.energyEarned = habit.energyReward
        
        if let note = note {
            habitEntry.notes = note
        }
        
        habit.addToEntries(habitEntry)
        
        coreDataManager.save()
        
        fetchHabits()
    }
    
    func deleteHabitEntry(_ habitEntry: HabitEntry) {
        guard let habit = habitEntry.habit else { return }
            
        habit.removeFromEntries(habitEntry)
        
        coreDataManager.viewContext.delete(habitEntry)
        
        coreDataManager.save()
        
        fetchHabits()
    }
    
    // MARK: - Category
    func createCategory(name: String, color: Color) -> Category {
        if let existingCategory = checkIfCategoryExists(name: name) {
            return existingCategory
        }
        
        let category = Category(context: coreDataManager.viewContext)
        
        category.id = UUID()
        category.name = name
        category.colorHex = color.toHex()
        category.createdAt = Date()
        
        coreDataManager.save()
        
        return category
    }
    
    func fetchAllCategories() -> [Category] {
        let request = NSFetchRequest<Category>(entityName: "Category")
            
        do {
            return try coreDataManager.viewContext.fetch(request)
        } catch {
            print("Error fetching categories: \(error)")
            return []
        }
    }
    
    func addHabitToCategory(habit: Habit, category: Category) {
        if let categoryHabits = category.habits,
           !categoryHabits.contains(where: { $0.id == habit.id }) {
            category.addToHabits(habit)
            coreDataManager.save()
            print("CATEGORY ADDED")
        }
    }
    
    // MARK: - Category Helper
    func checkIfCategoryExists(name: String) -> Category? {
        let request = NSFetchRequest<Category>(entityName: "Category")
        request.predicate = NSPredicate(format: "name == %@", name)
            
        do {
            let categories = try coreDataManager.viewContext.fetch(request)
            return categories.first
        } catch {
            print("Error checking category: \(error)")
            return nil
        }
    }
}
