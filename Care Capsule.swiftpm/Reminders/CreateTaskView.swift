//
//  CreateTaskView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-29.
//

//import SwiftUI
//
//@available(iOS 17.0, *)
//struct CreateTaskView: View {
//    @Binding var isShow: Bool
////    @Environment(\.managedObjectContext) private var viewContext
//    @Bindable var task: TaskEntity
////    @State private var taskName: String = ""
////    @State private var taskDescription: String = ""
////    @State private var taskFrequency: String = ""
////    @State private var taskDate: Date = Date()
////    @State private var taskPriority: Priority = .normal
//    @State private var isEditing: Bool = false // to track if TextField is being editit or not
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("Add new task")
//                        .font(.system(.title, design: .rounded))
//                        .fontWeight(.bold)
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        self.isShow = false
//                    }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.title3)
//                    }
//                }
//                
//                TextField("New task description", text: self.$taskName, onEditingChanged: { self.isEditing = $0 })
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(10)
//                    .padding(.bottom)
//                
//                Text("Priority")
//                    .fontWeight(.semibold)
////                
////                HStack {
////                    PriorityView(priorityTitle: "High", selectedPriority: self.$taskPriority)
////                        .onTapGesture { self.taskPriority = .high }
////                    
////                    PriorityView(priorityTitle: "Normal", selectedPriority: self.$taskPriority)
////                        .onTapGesture { self.taskPriority = .normal }
////                    
////                    PriorityView(priorityTitle: "Low", selectedPriority: self.$taskPriority)
////                        .onTapGesture { self.taskPriority = .low }
////                } //: HStack
//                DatePicker("Please enter a date", selection: $taskDate)
//                    .labelsHidden()
//                
//                Button (action: {
//                    // to make sure that task description is not empty
//                    guard self.taskName.trimmingCharacters(in: .whitespaces) != "" else { return }
//                    
//                    self.isShow = false
//                    self.addNewTask(name: self.taskName, frequency: ReminderModels.Frequency(rawValue: self.taskFrequency) ?? .once, description: self.taskDescription, date: self.taskDate)
//                }) {
//                    Text("Add new task")
//                        .font(.system(.title3, design: .rounded))
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                } //: Button
//                .cornerRadius(10)
//                .padding(.vertical)
//                
//            } //: VStack
//            .padding()
//            .background(Color.white)
//            .cornerRadius(10, antialiased: true)
//            .offset(y: self.isEditing ? -320 : 0) // to prevent the system keyboard to overlay on this view
//        } //: VStack
//        .edgesIgnoringSafeArea(.bottom)
//    }
//    
//    private func addNewTask(name: String, frequency: ReminderModels.Frequency, description: String?, date: Date) -> Void {
//        let newTask = TaskEntity(context: viewContext)
//        newTask.id = UUID()
//        newTask.title = name
//        newTask.frequency = frequency.rawValue
//        newTask.descrip = description ?? ""
//        newTask.checked = false
//        newTask.dateOfTask = date
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//struct BlankView: View {
//    var body: some View {
//        Color.black
//            .opacity(0.5)
//            .ignoresSafeArea()
//    }
//}
//
//#Preview {
//    CreateTaskView(isShow: .constant(true))
//}
