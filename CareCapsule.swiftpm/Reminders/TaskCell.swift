//
//  TaskCell.swift
//
//
//  Created by Elena Galluzzo on 2024-01-10.
//

import SwiftUI

struct TaskCell: View {
    @State var task: TaskEntity
    
    var body: some View {
        
        VStack {
            Text("\(task.dateOfTask.formatted(.dateTime.day().month().year())) | \(task.dateOfTask, style: .time)    ")
                .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                .foregroundColor(task.dateOfTask > Date() ? .black : .red)
            HStack {
                if task.checked {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        .foregroundColor(Color("capsuleDarkOrange"))
                        .onTapGesture {
                            task.checked = false
                        }
                } else {
                    Image(systemName: "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                        .foregroundColor(Color("capsuleDarkOrange"))
                        .onTapGesture {
                            task.checked = true
                            if task.frequency == "repeating" {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    task.dateOfTask = Calendar.current.date(byAdding: .day, value: 1, to: task.dateOfTask) ?? Date()
                                    task.checked = false
                                }
                            }
                        }
                }
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(2)
                        .foregroundColor(Color("capsuleDarkOrange"))
//                        .frame(width: 270, alignment: .leading)
                    Text(String(task.descrip))
                        .font(.title3)
                        .lineLimit(5)
                        .fontWeight(.semibold)
//                        .frame(width: 270, alignment: .leading)
                    Text(String(task.frequency))
                        .font(.footnote)
//                        .frame(width: 270, alignment: .leading)
                    Spacer()
                }
                .padding(.vertical, 8)
                Spacer()
            }
        }
    }
}
