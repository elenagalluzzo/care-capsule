//
//  ReminderCells.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct PillCell: View {
    var pillCell: ReminderModels.PillCellModel
    var body: some View {
        HStack {
            Image(pillCell.checkBoxImageName ?? "")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(5)
                .padding(.leading, 8)
            VStack {
                Text(pillCell.medication ?? "")
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(2)
                Text(pillCell.frequency?.rawValue ?? "")
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}

struct TaskCell: View {
    var taskCell: ReminderModels.TasksCellModel
    var body: some View {
        VStack {
            Text(taskCell.date ?? "")
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
                    Text(taskCell.frequency?.rawValue ?? "")
                    Text(taskCell.description ?? "")
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}
