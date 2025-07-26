//
//  HabitCreationView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 11.07.2025.
//

import SwiftUI
import CoreData

struct HabitCreationView: View {
    @EnvironmentObject private var viewModel: HabitViewModel
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.createdAt, ascending: false)
        ]
    ) private var categories: FetchedResults<Category>
    
    @State private var titleTextField: String = ""
    @State private var descriptionTextField: String = ""
    @State private var selectedWeekdays: Set<Int> = [1,2,3,4,5,6,7]
    @State private var selectedCategoryIDs: [NSManagedObjectID] = []
    
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
            HabitCreationInfoSection(title: $titleTextField,
                                     description: $descriptionTextField)
            
            WeekdaySelectionSection(selectedWeekdays: $selectedWeekdays)
            
            CategorySelectionSection(categories: Array(categories),
                                     selectedCategoryIDs: $selectedCategoryIDs)
            
            Button {
                let selectedCategories = categories.filter {
                    selectedCategoryIDs.contains($0.objectID)
                }
                
                let _ = viewModel.createHabit(title: titleTextField,
                                      descriptionText: descriptionTextField,
                                      targetDays: Array(selectedWeekdays),
                                      categories: selectedCategories)
                
                dismiss()
            } label: {
                Text("Create")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(!titleTextField.isEmpty ? Color.accentColor : Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .scaleEffect(!titleTextField.isEmpty ? 1.0 : 0.95)
                    .animation(.easeInOut(duration: 0.2), value: !titleTextField.isEmpty)
            }
            .buttonStyle(.plain)
            .disabled(titleTextField.isEmpty)
            .padding(.horizontal)
        }
    }
}

#Preview {
    HabitCreationView()
}
