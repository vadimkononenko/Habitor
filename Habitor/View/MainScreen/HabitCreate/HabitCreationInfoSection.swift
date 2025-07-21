//
//  HabitCreationInfoSection.swift
//  Habitor
//
//  Created by Vadim Kononenko on 21.07.2025.
//

import SwiftUI

struct HabitCreationInfoSection: View {
    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        Section("Info") {
            TextField("Title", text: $title)
            
            TextField("Description", text: $description)
        }
    }
}
