//
//  ReminderCells.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct PillCell: View {
    @State var pill: MedicationEntity
    var body: some View {
        VStack {
            Text(pill.firstDate.formatted(.dateTime.day().month().year()))
            HStack {
                if pill.checked {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        .padding(.leading, 8)
                        .onTapGesture {
                            pill.checked = false
                        }
                } else {
                    Image(systemName: "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        .padding(.leading, 8)
                        .onTapGesture {
                            pill.checked = true
                            if pill.frequency == "repeating" {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    pill.firstDate = Calendar.current.date(byAdding: .day, value: 1, to: pill.firstDate)!
                                    pill.checked = false
                                }
                            }
                        }
                }
                VStack {
                    Text(pill.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Text(String(pill.frequency))
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}
