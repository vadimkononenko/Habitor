//
//  HabitCreationView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 11.07.2025.
//

import SwiftUI

struct HabitCreationView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.createdAt, ascending: false)
        ]
    ) private var categories: FetchedResults<Category>
    
    @State private var titleTextField: String = ""
    @State private var descriptionTextField: String = ""
    @State private var selectedWeekdays: Set<Int> = [1,2,3,4,5,6,7]
    @State private var selectedCategory: Category?
    
    private var weekdays = [
        (1, "MON"),
        (2, "TUE"),
        (3, "WED"),
        (4, "THU"),
        (5, "FRI"),
        (6, "SAT"),
        (7, "SUN")
    ]
    
    var body: some View {
        Form {
            HabitCreationInfoSection(title: $titleTextField, description: $descriptionTextField)
            
            WeekdaySelectionSection(selectedWeekdays: $selectedWeekdays)
            
            CategorySelectionSection(categories: Array(categories), selectedCategory: $selectedCategory)
        }
    }
}

#Preview {
    HabitCreationView()
}
