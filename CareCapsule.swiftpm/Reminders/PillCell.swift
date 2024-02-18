//
//  PillCell.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct PillCell: View {
    @State var pill: MedicationEntity
    var body: some View {
        VStack {
            Text("\(pill.firstDate.formatted(.dateTime.day().month().year())) | \(pill.firstDate, style: .time)    ")
                .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                .foregroundColor(pill.firstDate > Date() ? .black : .red)
            HStack {
                if pill.checked {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        .foregroundColor(Color("capsuleDarkPurple"))
                        .onTapGesture {
                            pill.checked = false
                        }
                } else {
                    Image(systemName: "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        .foregroundColor(Color("capsuleDarkPurple"))
                        .onTapGesture {
                            pill.checked = true
                            if pill.frequency == "repeating" {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    pill.firstDate = Calendar.current.date(byAdding: .day, value: 1, to: pill.firstDate) ?? Date()
                                    pill.checked = false
                                }
                            }
                        }
                }
                VStack(alignment: .leading) {
                    Text(pill.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .foregroundColor(Color("capsuleDarkPurple"))
                    Text(String(pill.frequency))
                        .font(.footnote)
                    Spacer()
                }
                .padding(.vertical, 8)
                Spacer()
            }
        }
    }
}
