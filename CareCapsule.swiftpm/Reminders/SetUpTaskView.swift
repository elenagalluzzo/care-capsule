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
    @Bindable var task: TaskEntity
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                TextField("Task Title", text: $task.title)
                TextField("Description", text: $task.descrip, axis: .vertical)
                DatePicker("Please enter a date", selection: $task.dateOfTask)
                    .labelsHidden()
                
                Button("Add", action: addTask)
            }
        }
    }
    
    func addTask() {
        guard task.title.isEmpty == false else { return }
        withAnimation {
            let newTask = TaskEntity(title: task.title, descrip: task.descrip, frequency: "", checked: false, dateOfTask: task.dateOfTask)
            modelContext.insert(newTask)
        }
    }
}

//#Preview {
//    SetUpTaskView()
//}
