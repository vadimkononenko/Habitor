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
            let entryDate = entry.date
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
    
    func createHabit(title: String,
                     descriptionText: String,
                     targetDays: [Int] = [1,2,3,4,5,6,7],
                     categories: [Category]? = nil) -> Habit {
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
        
        if let categories = categories {
            categories.forEach {
                habit.addToCategories($0)
            }
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
        
        updateHabitStatistics(for: habit)
        
        coreDataManager.save()
        
        fetchHabits()
    }
    
    func deleteHabitEntry(_ habitEntry: HabitEntry) {
        let habit = habitEntry.habit
            
        habit.removeFromEntries(habitEntry)
        
        coreDataManager.viewContext.delete(habitEntry)
        
        updateHabitStatistics(for: habit)
        
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

// MARK: - Statistic Methods
extension HabitViewModel {
    func updateHabitStatistics(for habit: Habit) {
        updateTotalCompletions(for: habit)
        updateCurrentStreak(for: habit)
        updateBestStreak(for: habit)
            
        habit.updatedAt = Date()
        coreDataManager.save()
    }
    
    private func updateTotalCompletions(for habit: Habit) {
        guard let entries = habit.entries else {
            habit.totalCompletions = 0
            return
        }
        
        let completedEntries = entries.filter { $0.isCompleted }
        habit.totalCompletions = Int32(completedEntries.count)
    }
    
    private func updateCurrentStreak(for habit: Habit) {
        guard let entries = habit.entries else {
            habit.currentStreak = 0
            return
        }
        
        let sortedEntries = entries
            .filter { $0.isCompleted }
            .sorted { $0.date < $1.date }
        
        if sortedEntries.isEmpty {
            habit.currentStreak = 0
            return
        }
        
        let calendar = Calendar.current
        let today = Date()
        var currentStreak = 0
        var checkDate = today
        
        while true {
            let weekday = calendar.component(.weekday, from: checkDate)
            let adjastedWeekday = weekday == 1 ? 7 : weekday - 1
            
            if habit.targetDays.contains(adjastedWeekday) {
                let hasEntryForDate = sortedEntries.contains { entry in
                    calendar.isDate(entry.date, inSameDayAs: checkDate)
                }
                
                if hasEntryForDate {
                    currentStreak += 1
                } else {
                    break
                }
            }
            
            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: checkDate) else { break }
            checkDate = previousDay
            
            let firstHabitEntryDate = sortedEntries.last?.date ?? today
            
            if calendar.isDate(checkDate, inSameDayAs: firstHabitEntryDate) {
                break
            }
        }
        
        habit.currentStreak = Int32(currentStreak)
//        if currentStreak > habit.bestStreak {
//            habit.bestStreak = Int32(currentStreak)
//        }
    }
    
    private func updateBestStreak(for habit: Habit) {
        guard let entries = habit.entries else {
            habit.bestStreak = 0
            return
        }
        
        let sortedEntries = entries
            .filter { $0.isCompleted }
            .sorted { $0.date < $1.date }
        
        if sortedEntries.isEmpty {
            habit.bestStreak = 0
            return
        }
        
        let calendar = Calendar.current
        var maxStreak = 0
        var currentStreakCount = 0
        var lastDate: Date?
        
        for entry in sortedEntries {
            let entryDate = entry.date
            
            if let lastDate {
                if isNextTargetDay(from: lastDate,
                                   to: entryDate,
                                   targetDays: habit.targetDays,
                                   calendar: calendar) {
                    currentStreakCount += 1
                } else {
                    maxStreak = max(maxStreak, currentStreakCount)
                    currentStreakCount = 1
                }
            } else {
                currentStreakCount = 1
            }
            
            lastDate = entryDate
        }
        
        maxStreak = max(maxStreak, currentStreakCount)
        habit.bestStreak = Int32(maxStreak)
    }
    
    private func isNextTargetDay(from fromDate: Date, to toDate: Date, targetDays: [Int], calendar: Calendar) -> Bool {
        var checkDate = fromDate
            
        while checkDate < toDate {
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: checkDate) else {
                return false
            }
            checkDate = nextDay
                
            let weekday = calendar.component(.weekday, from: checkDate)
            let adjustedWeekday = weekday == 1 ? 7 : weekday - 1
                
            if targetDays.contains(adjustedWeekday) {
                return calendar.isDate(checkDate, inSameDayAs: toDate)
            }
        }
            
        return false
    }
    
    func getHabitStatistics(for habit: Habit) -> (bestStreak: Int, currentStreak: Int, totalCompletions: Int) {
        return (
            bestStreak: Int(habit.bestStreak),
            currentStreak: Int(habit.currentStreak),
            totalCompletions: Int(habit.totalCompletions)
        )
    }
}
