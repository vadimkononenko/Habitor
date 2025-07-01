//
//  MainView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 01.07.2025.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    
    var body: some View {
        ScrollView(.vertical,
                   showsIndicators: false) {
            VStack {
                HeadrerProgressView(allHabitsCount: 5,
                                    currentCompletedHabitsCount: 3,
                                    allEnergyCount: 20,
                                    currentEnergyCount: 5)
                .padding()
                
                
                
                HabitCardView(title: "Do pushpamps after fulltime job",
                              specs: ["Self-improvment", "Work"],
                              currentDate: Date.now,
                              energyCount: 5)
                HabitCardView(title: "Study english in the evening",
                              specs: ["English"],
                              currentDate: Calendar.current
                    .date(byAdding: .day, value: -2, to: Date.now)!,
                              energyCount: 10)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
