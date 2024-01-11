//
//  PillsView.swift
//
//
//  Created by Elena Galluzzo on 2024-01-10.
//

import SwiftUI
import SwiftData

struct PillsView: View {
    @Environment(\.modelContext) var modelContext
    @State var prompt: AssistantModels.Prompts?
    @State private var showSetUp = false
    @Query var pills: [MedicationEntity]
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color(.capsuleLightPurple))
                    List {
                        ForEach(pills) { pill in
                            PillCell(pillCell: ReminderModels.PillCellModel(frequency: .once, medication: pill.title, checked: false, date: pill.firstDate))
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    Group {
                        MiniAssistantHelperView(prompt: prompt, isTalking: true)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                }
            }
            .background(Color(.capsuleLightOrange).opacity(0.3))
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    showSetUp.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                })
            }
        }
        .sheet(isPresented: $showSetUp, content: {
            NavigationStack {
                SetUpPillView()
            }
            .presentationDetents([.medium])
        })
        
        .navigationTitle("Medication")
    }
        
}

#Preview {
    PillsView()
}
