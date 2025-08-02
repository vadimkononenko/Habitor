//
//  Habit+CoreDataProperties.swift
//  Habitor
//
//  Created by Vadim Kononenko on 27.06.2025.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var bestStreak: Int32
    @NSManaged public var createdAt: Date?
    @NSManaged public var currentStreak: Int32
    @NSManaged public var descriptionText: String?
    @NSManaged public var energyReward: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var reminderTime: Date?
    @NSManaged public var targetDaysData: Data?
    @NSManaged public var title: String
    @NSManaged public var totalCompletions: Int32
    @NSManaged public var updatedAt: Date?
    @NSManaged public var categories: Set<Category>?
    @NSManaged public var entries: Set<HabitEntry>?

}

extension Habit {
    var targetDays: [Int] {
        get {
            guard let data = targetDaysData else { return [] }
            
            do {
                return try JSONDecoder().decode([Int].self, from: data)
            } catch {
                print("Error decoding targetDays JSON: \(error)")
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                self.targetDaysData = data
            } catch {
                print("Error encoding targetDays JSON: \(error)")
            }
        }
    }
}

// MARK: Generated accessors for categories
extension Habit {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

// MARK: Generated accessors for entries
extension Habit {

    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: HabitEntry)

    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: HabitEntry)

    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)

    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)

}

extension Habit : Identifiable {

}
