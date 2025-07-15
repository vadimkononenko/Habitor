//
//  HabitCreationView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 11.07.2025.
//

import SwiftUI

struct HabitCreationView: View {
    @State private var titleTextField: String = ""
    @State private var descriptionTextField: String = ""
    
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
            Section("Info") {
                TextField("Title", text: $titleTextField)
                
                TextField("Description", text: $descriptionTextField)
            }
            
            Section("Frequency") {
                HStack {
                    ForEach(weekdays, id: \.0) { day in
                        ZStack {
                            Text("\(day.1)")
                                .font(.caption)
                        }
                        .cornerRadius(5)
                    }
                }
            }
        }
    }
}

#Preview {
    HabitCreationView()
}
