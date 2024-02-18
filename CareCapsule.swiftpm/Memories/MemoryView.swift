//
//  MemoryView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI
import SwiftData

struct MemoryView: View {
    @Environment(\.modelContext) var modelContext
    @Query var memories: [MemoryEntity]
    @EnvironmentObject var memoryViewModel: MemoryViewModel
    @EnvironmentObject var imageViewModel: ImageSelectionViewModel
    @State private var showSetUp: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    List {
                        ForEach(memories) { memory in
                            MemoryCellView(memory: memory, viewModel: imageViewModel)
                        }
                        .onDelete(perform: deleteMemory)
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    MiniAssistantHelperView(prompt: memoryViewModel.memoryPrompt, isTalking: true)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                    
                }
                
                .background(Color("capsuleLightOrange").opacity(0.3))
            }
            .navigationTitle("Memories")
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
                    SetUpMemoryView(showSetUp: $showSetUp, viewModel: imageViewModel)
                }
                .presentationDetents([.medium])
            })
            
        }
    }
    func deleteMemory(_ indexSet: IndexSet) {
        for index in indexSet {
            let memory = memories[index]
            modelContext.delete(memory)
        }
    }
}


#Preview {
    MemoryView()
}
