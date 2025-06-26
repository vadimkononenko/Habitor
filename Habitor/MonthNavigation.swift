//
//  MonthNavigation.swift
//  Habitor
//
//  Created by Vadim Kononenko on 25.06.2025.
//

import SwiftUI

struct MonthNavigation: View {
    @Binding var selectedMonth: Date
        
    var body: some View {
        HStack {
            Button(action: previousMonth) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
                
            Spacer()
                
            Text(selectedMonth.formatted(.dateTime.month(.wide).year()))
                .font(.title2)
                .fontWeight(.semibold)
                
            Spacer()
                
            Button(action: nextMonth) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(isCurrentMonth ? .gray : .blue)
            }
            .disabled(isCurrentMonth)
        }
    }
        
    private func previousMonth() {
        selectedMonth = Calendar.current
            .date(
                byAdding: .month,
                value: -1,
                to: selectedMonth
            ) ?? selectedMonth
    }
        
    private func nextMonth() {
        selectedMonth = Calendar.current
            .date(
                byAdding: .month,
                value: 1,
                to: selectedMonth
            ) ?? selectedMonth
    }
        
    private var isCurrentMonth: Bool {
        Calendar.current
            .isDate(selectedMonth, equalTo: Date(), toGranularity: .month)
    }
}

#Preview {
    MonthNavigation(
        selectedMonth: .constant(Date())
    )
    .padding()
}
