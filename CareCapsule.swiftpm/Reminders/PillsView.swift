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
    @State private var showSetUp: Bool = false
    @Query(sort: \MedicationEntity.firstDate) var pills: [MedicationEntity]
    @EnvironmentObject var pillsViewModel: PillsViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    List {
                        ForEach(pills) { pill in
                            PillCell(pill: pill)
                        }
                        .onDelete(perform: deletePill)
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    Group {
                        MiniAssistantHelperView(prompt: pillsViewModel.pillsPrompt, isTalking: true)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                }
            }
            .background(Color("capsuleLightOrange").opacity(0.3))
            .navigationTitle("Medication")
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
                Color("capsuleMediumPurple"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $showSetUp, content: {
                NavigationStack {
                    SetUpPillView(showSetUp: $showSetUp)
                }
                .presentationDetents([.medium])
            })
        }
        .onAppear {
            if pills.count == 0 {
                pillsViewModel.pillsPrompt = .setUpPill
            } else {
                pillsViewModel.pillsPrompt = .pillsToTake
            }
        }
    }
    func deletePill(_ indexSet: IndexSet) {
        for index in indexSet {
            let pill = pills[index]
            modelContext.delete(pill)
        }
    }
}

#Preview {
    PillsView()
}
