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
        VStack {
            Text(pillCell.date.formatted(.iso8601.year().month().day()))
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
                    Text(String(pillCell.frequency?.rawValue ?? ""))
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}
