import SwiftUI

enum Tab {
    case pills, assistant, resources
}

enum AssistantNavigation: Hashable {
    case child
}

@available(iOS 17.0, *)
struct TabBarView: View {
    @State private var selection: Tab = .assistant
    @State private var assistantNavigationStack: [AssistantNavigation] = []
    var body: some View {
        TabView(selection: $selection) {
            Group {
                PillsView(prompt: .setUpPill).tag(Tab.pills)
                    .tabItem {
                        Label("Pills", systemImage: "person")
                    }
                
//                ReminderView(prompt: .reminderGeneral).tag(2)
//                    .tabItem {
//                        Label("Tasks", systemImage: "person").font(.system(size: 80))
//                    }
                
                AssistantPromptsView(selection: $selection, path: $assistantNavigationStack).tag(Tab.assistant)
                    .tabItem {
                        Label("Assistant", image: "Assistant-tab")
                    }
                
//                PeopleView(prompt: .lovedOnesGeneral).tag(4)
//                    .tabItem {
//                        Label("Loved Ones", systemImage: "person").font(.system(size: 80))
//                    }
                ResourcesView(prompt: .resources).tag(Tab.resources)
                    .tabItem {
                        Label("Resources", systemImage: "person")
                    }
            }
        }
        .toolbarBackground(Color("capsuleLightPurple"), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
    
}

extension TabBarView {
    private func tabSelection() -> Binding<Tab> {
        Binding {
            self.selection
        } set: { tappedTab in
            if tappedTab == self.selection {
                if assistantNavigationStack.isEmpty {
                } else {
                    assistantNavigationStack = []
                }
            }
            self.selection = tappedTab
        }
    }
}
