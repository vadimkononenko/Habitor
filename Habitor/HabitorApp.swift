//
//  HabitorApp.swift
//  Habitor
//
//  Created by Vadim Kononenko on 20.06.2025.
//

import SwiftUI

enum NavigationTabs {
    case main
    case statistic
}

@main
struct HabitorApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var habitViewModel = HabitViewModel(coreDataManager: CoreDataManager.shared)
    @State private var selectedTab: NavigationTabs = .main
    
    let persistenceController = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                Tab(value: .main) {
                    MainView()
                } label: {
                    VStack {
                        Text("Main")
                        Image(systemName: "house")
                    }
                }
                
                Tab(value: .statistic) {
                    StatisticView()
                } label: {
                    VStack {
                        Text("Statistic")
                        Image(systemName: "chart.bar.fill")
                    }
                }
            }
            .environmentObject(habitViewModel)
            .environment(\.managedObjectContext, persistenceController.viewContext)
        }
        .onChange(of: scenePhase) { _, _ in
            persistenceController.save()
        }
    }
}
