import SwiftUI

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
    var body: some View {
        TabView(selection: $selection) {
            Group {
                PillsView().tag(Tab.pills)
                    .tabItem {
                        Label("Pills", systemImage: "pill")
                    }
                    .onTapGesture {
                        pillsViewModel.pillsPrompt = .setUpPill
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

