//
//  TaskCell.swift
//
//
//  Created by Elena Galluzzo on 2024-01-10.
//

import SwiftUI

struct TaskCell: View {
    var taskCell: ReminderModels.TasksCellModel
    
    var body: some View {
        
        VStack {
            Text(taskCell.date.formatted(.iso8601.year().month().day()))
            HStack {
                Image(taskCell.checkBoxImageName ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(5)
                    .padding(.leading, 8)
                VStack {
                    Text(taskCell.title ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Text(String(taskCell.frequency?.rawValue ?? ""))
                    Text(taskCell.description ?? "")
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        
    }
}
