//
//  HabitorApp.swift
//  Habitor
//
//  Created by Vadim Kononenko on 20.06.2025.
//

import SwiftUI

@main
struct HabitorApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
        .onChange(of: scenePhase) { _, _ in
            persistenceController.save()
        }
    }
}
