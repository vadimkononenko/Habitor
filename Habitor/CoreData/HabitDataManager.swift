//
//  HabitDataManager.swift
//  Habitor
//
//  Created by Vadim Kononenko on 26.06.2025.
//

import Foundation
import CoreData
import SwiftUI

class HabitDataManager: ObservableObject {
    private let coreDataStack = CoreDataStack.shared
    
    var context: NSManagedObjectContext {
        coreDataStack.context
    }
    
    private func save() {
        coreDataStack.save()
    }
}
