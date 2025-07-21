//
//  WeekdaySelectionSection.swift
//  Habitor
//
//  Created by Vadim Kononenko on 21.07.2025.
//

import SwiftUI

struct WeekdaySelectionSection: View {
    @Binding var selectedWeekdays: Set<Int>
    
    private let weekdays = [(1, "MON"), (2, "TUE"), (3, "WED"), (4, "THU"),
                            (5, "FRI"), (6, "SAT"), (7, "SUN")]
    
    var body: some View {
        Section("Frequency") {
            HStack {
                ForEach(weekdays, id: \.0) { day in
                    WeekdayButtonView(
                        day: day,
                        isSelected: selectedWeekdays.contains(day.0)
                    ) {
                        toggleWeekday(day.0)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

extension WeekdaySelectionSection {
    private func toggleWeekday(_ weekday: Int) {
        if selectedWeekdays.contains(weekday) {
            selectedWeekdays.remove(weekday)
        } else {
            selectedWeekdays.insert(weekday)
        }
    }
}
