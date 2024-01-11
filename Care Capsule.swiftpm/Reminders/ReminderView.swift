//
//  ReminderView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct ReminderView: View {
    @State var prompt: AssistantModels.Prompts?
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(
//        entity: TaskEntity.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \TaskEntity.checked, ascending: true),
//        ],
//        animation: .default
//    )
//    private var tasks: FetchedResults<TaskEntity>
    @Environment(\.modelContext) var modelContext
    @Query var tasks: [TaskEntity]
    @State private var showNewTask: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Divider()
                        .background(Color(.capsuleDarkPurple))
                    List {
                        Section() {
                            HStack() {
                                Text("Tasks")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.capsuleDarkOrange))
                                Image("Assistant-1")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 20)
                            .listRowInsets(EdgeInsets())
                        }
                        
                        .listRowBackground(Color(.clear))
                        Section {
                            ForEach(tasks) { task in
                                TaskCell(taskCell: ReminderModels.TasksCellModel(description: task.descrip, title: task.title, checked: task.checked, date: task.dateOfTask))
                            }
                            .onDelete(perform: deleteTask)
                        }
                        .listRowBackground(Color(.capsuleLightOrange))
                        if tasks.count == 0 {
                            Image("no-data")
                                .resizable()
                                .scaledToFit()
                        }
                        
                        
                        Section() {
                            HStack() {
                                Text("Medication")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.capsuleDarkPurple))
                                Image("Assistant-1")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .listRowInsets(EdgeInsets())
                        }
                        .listRowBackground(Color(.clear))
                        Section {
                            PillCell(pillCell: ReminderModels.PillCellModel(frequency: .once, medication: "Med", checked: false, date: Date()))
                            PillCell(pillCell: ReminderModels.PillCellModel(frequency: .once, medication: "Med", checked: false, date: Date()))
                        }
                        .listRowBackground(Color(.capsuleLightPurple))
                        
                    }
                    .background(Color(.capsuleLightOrange).opacity(0.3))
                }
                
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    Group {
                        MiniAssistantHelperView(prompt: prompt, isTalking: true)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                }
                if self.showNewTask {
//                SetUpTaskView(task: task)
//                    BlankView()
//                        .onTapGesture { self.showNewTask = false }
//                    VStack {
//                        CreateTaskView(isShow: self.$showNewTask)
//                            .transition(.move(edge: .bottom))
//                            .animation(.default, value: self.showNewTask)
//                        Spacer()
                    }
                }
                
            }
            
            .navigationTitle("Life Manager")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color(.capsuleMediumPurple),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showNewTask = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    } //: Button
                } //: ToolbarItem
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.blue)
                        .opacity(self.tasks.count == 0 ? 0.5 : 1)
                        .disabled(self.tasks.count == 0)
                } //: ToolbarItem
            }
        
    }
private func deleteTask(at offsets: IndexSet) -> Void {
        withAnimation {
            for offset in offsets {
                let task = tasks[offset]
                modelContext.delete(task)
            }
        }
    }
}

//#Preview {
//    ReminderView(prompt: .pillsToTake)
//}
