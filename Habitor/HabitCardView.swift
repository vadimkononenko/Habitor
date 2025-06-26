//
//  HabitCardView.swift
//  Habitor
//
//  Created by Vadim Kononenko on 22.06.2025.
//

import SwiftUI

/*
 1) 3 часа на практику создания приложений
 2) 1 час на практику решения алгоритмических задач
 3) 1.5 часа английского
 
 просто я уже понимаю, что уже не вывожу эту нагрузку
 мне нужно перезагрузка + перемены в лучшую сторону, бо я прийду к тому же самому и тупо не смогу уже вывезти
 поменять сферу на ту, которую действительно хочу и стремлюсь
 моя сейчас проблема что я боюсь рисковать
 однако в этом сейчас и заключается моя сила, чтоб у меня были силы стать намного лучше и сильнее для достижения
 поставленной цели
 */

struct HabitCardView: View {
    
    var title: String
    var specs: [String]
    var currentDate: Date
    var energyCount: Int
    var isCompleted: Bool = false
    
    var formattedDate: String {
        currentDate.formatted(date: .numeric, time: .omitted)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(title)
                
                Spacer()
                
                Image(systemName: "ellipsis")
            }
            
            HStack {
                ForEach(specs, id: \.self) { spec in
                    Text(spec)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 12)
                        .background(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
                        .cornerRadius(12)
                        .font(.caption2)
                }
            }
            
            HStack(spacing: 40) {
                HStack {
                    Image(systemName: "calendar")
                    
                    Text(formattedDate)
                }
                .font(.footnote)
                
                HStack(spacing: 18) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)))
                        .frame(height: 5)
                        .frame(maxWidth: .infinity)
                    
                    Text("\(energyCount)⚡️")
                }
                .frame(maxWidth: .infinity)
            }
            
            Button {
                //action
            } label: {
                HStack {
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                    
                    Text(isCompleted ? "Completed" : "Complete")
                }
                .foregroundColor(Color.white)
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(Color(#colorLiteral(red: 1, green: 0.7066476341, blue: 0.3261104689, alpha: 1)))
                .cornerRadius(6)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
        )
    }
}

#Preview {
    HabitCardView(title: "Do pushpamps after fulltime job",
                  specs: ["Self-improvment", "Work"],
                  currentDate: Date.now,
                  energyCount: 5)
}
