//
//  HabitEntry+CoreDataProperties.swift
//  Habitor
//
//  Created by Vadim Kononenko on 27.06.2025.
//
//

import Foundation
import CoreData


extension HabitEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitEntry> {
        return NSFetchRequest<HabitEntry>(entityName: "HabitEntry")
    }

    @NSManaged public var completedAt: Date
    @NSManaged public var date: Date
    @NSManaged public var energyEarned: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var notes: String?
    @NSManaged public var habit: Habit

}

extension HabitEntry : Identifiable {

}
