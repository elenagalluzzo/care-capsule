//
//  SetUpTaskView.swift
//
//
//  Created by Elena Galluzzo on 2024-01-04.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct SetUpTaskView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var showSetUp: Bool
    @Bindable var task: TaskEntity = TaskEntity()
    var body: some View {
        List {
            VStack {
                
                TextField("Task Title", text: $task.title)
                TextField("Description", text: $task.descrip, axis: .vertical)
                DatePicker("Please enter a date", selection: $task.dateOfTask)
                    .labelsHidden()
                Picker("Frequency", selection: $task.frequency) {
                    ForEach(ReminderModels.Frequency.allCases) { frequency in
                        Text(frequency.rawValue).tag(frequency.rawValue)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
                
                Button("Add") {
                    modelContext.insert(task)
                    showSetUp = false
                    
                }
            }
        }
    }
}

//#Preview {
//    SetUpTaskView()
//}
