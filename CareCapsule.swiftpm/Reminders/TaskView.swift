//
//  TaskView.swift
//
//
//  Created by Elena Galluzzo on 2024-02-04.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showSetUp: Bool = false
    @Query(sort: \TaskEntity.dateOfTask) var tasks: [TaskEntity]
    @EnvironmentObject var taskViewModel: TaskViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    List {
                        ForEach(tasks) { task in
                            TaskCell(task: task)
                        }
                        .onDelete(perform: deleteTask)
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    Group {
                        MiniAssistantHelperView(prompt: taskViewModel.taskPrompt, isTalking: true)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                }
            }
            .background(Color("capsuleLightOrange").opacity(0.3))
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSetUp.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    })
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color("capsuleDarkOrange"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $showSetUp, content: {
                NavigationStack {
                    SetUpTaskView(showSetUp: $showSetUp)
                }
                .presentationDetents([.medium])
            })
        }
        .onAppear {
            if tasks.count == 0 {
                taskViewModel.taskPrompt = .reminderGeneral
            } else {
                taskViewModel.taskPrompt = .tasksToday
            }
        }
    }
    func deleteTask(_ indexSet: IndexSet) {
        for index in indexSet {
            let task = tasks[index]
            modelContext.delete(task)
        }
    }
}

#Preview {
    TaskView()
}
