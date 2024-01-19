//
//  ReminderCells.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct PillCell: View {
    @State var pillCell: ReminderModels.PillCellModel
//    @StateObject var checked = pillCell.checked
    var body: some View {
        VStack {
            Text(pillCell.date.formatted(.iso8601.year().month().day()))
            HStack {
                if pillCell.checked {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        .padding(.leading, 8)
                        .onTapGesture {
                            pillCell.checked = false
                        }
                } else {
                    Image(systemName: "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        .padding(.leading, 8)
                        .onTapGesture {
                            pillCell.checked = true
                        }
                }
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
