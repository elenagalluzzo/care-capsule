import SwiftUI
import SwiftData

enum Tab {
    case pills, tasks, assistant, memories, resources
}

enum AssistantNavigation: Hashable {
    case child
}

@available(iOS 17.0, *)
struct TabBarView: View {
    @State private var selection: Tab = .assistant
    @EnvironmentObject var pillsViewModel: PillsViewModel
    @Query var pills: [MedicationEntity]
    var body: some View {
        TabView(selection: $selection) {
            Group {
                PillsView().tag(Tab.pills)
                    .tabItem {
                        Label("Pills", systemImage: "pill")
                    }
                    .onTapGesture {
                            if pills.count == 0 {
                                pillsViewModel.pillsPrompt = .setUpPill
                            } else {
                                pillsViewModel.pillsPrompt = .pillsToTake
                            }
                            self.selection = Tab.pills
                    }
                
                TaskView().tag(Tab.tasks)
                    .tabItem {
                        Label("Tasks", systemImage: "calendar.badge.checkmark").font(.system(size: 80))
                    }
                
                AssistantPromptsView(selection: $selection).tag(Tab.assistant)
                    .tabItem {
                        Label("Assistant", systemImage: "person")
                    }
                MemoryView().tag(Tab.memories)
                    .tabItem {
                        Label("Memories", systemImage: "heart").font(.system(size: 80))
                    }
                ResourcesView(prompt: .resources).tag(Tab.resources)
                    .tabItem {
                        Label("Resources", systemImage: "phone.bubble")
                    }
            }
        }
        .toolbarBackground(Color("capsuleLightPurple"), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
    
}

