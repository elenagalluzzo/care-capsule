//
//  ReminderView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct ReminderView: View {
    @State var prompt: AssistantModels.Prompts?
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Divider()
                        .background(Color(.capsuleLightPurple))
                    List {
                        Section()
                        {
                            HStack() {
                                Text("TASKS")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.capsuleLightPurple))
                                Image("HeadImage")
                                    .resizable()
                                    .frame(width: 50, height: 20)
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 20)
                            .listRowInsets(EdgeInsets())
                        }
                        .listRowBackground(Color(.capsuleDarkPurple))
                        Section {
                            TaskCell(taskCell: ReminderModels.TasksCellModel(description: "get milk", title: "Grocery Shop"))
                            TaskCell(taskCell: ReminderModels.TasksCellModel(description: "get milk", title: "Grocery Shop"))
                        }
                        .listRowBackground(Color(.capsuleLightOrange))
                        //                    ForEach(items) { item in
                        //                        PillsCell(title: item.title, subtitle: item.subtitle, image: item.image)
                        //                    }
                        
                        
                        Section()
                        {
                            HStack() {
                                Text("MEDICATION")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.capsuleLightPurple))
                                Image("HeadImage")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .listRowInsets(EdgeInsets())
                        }
                        .listRowBackground(Color(.capsuleDarkPurple))
                        Section {
                            PillCell(pillCell: ReminderModels.PillCellModel(frequency: .once, medication: "Med"))
                            PillCell(pillCell: ReminderModels.PillCellModel(frequency: .once, medication: "Med"))
                        }
                        .listRowBackground(Color(.capsuleLightOrange))
                        
                    }
                    .background(Color.white)
                }
                
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    Group {
                        MiniAssistantHelperView(prompt: prompt, isTalking: true)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                }
                Spacer()
            }
            .navigationTitle("Life Manager")
        }
    }

}

#Preview {
    ReminderView(prompt: .pillsToTake)
}
