//
//  User+CoreDataProperties.swift
//  Habitor
//
//  Created by Vadim Kononenko on 27.06.2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatarImageData: Data?
    @NSManaged public var createdAt: Date?
    @NSManaged public var dailyHabitsGoal: Int32
    @NSManaged public var energyGoal: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var isPremium: Bool
    @NSManaged public var name: String?
    @NSManaged public var habits: NSSet?

}

// MARK: Generated accessors for habits
extension User {

    @objc(addHabitsObject:)
    @NSManaged public func addToHabits(_ value: Habit)

    @objc(removeHabitsObject:)
    @NSManaged public func removeFromHabits(_ value: Habit)

    @objc(addHabits:)
    @NSManaged public func addToHabits(_ values: NSSet)

    @objc(removeHabits:)
    @NSManaged public func removeFromHabits(_ values: NSSet)

}

extension User : Identifiable {

}
