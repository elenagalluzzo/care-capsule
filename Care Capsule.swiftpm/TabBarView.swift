import SwiftUI

@available(iOS 17.0, *)
struct TabBarView: View {
    @State private var selection = 2
    var body: some View {
        TabView(selection: $selection) {
            Group {
                PillsView(prompt: .reminderGeneral).tag(1)
                    .tabItem {
                        Label("Pills", systemImage: "person").font(.system(size: 80))
                    }
                
                ReminderView(prompt: .reminderGeneral).tag(1)
                    .tabItem {
                        Label("Tasks", systemImage: "person").font(.system(size: 80))
                    }
                
                AssistantPromptsView().tag(2)
                    .tabItem {
                        Label("Assistant", image: "Assistant-tab").font(.system(size: 80))
                    }
                
                PeopleView(prompt: .lovedOnesGeneral).tag(3)
                    .tabItem {
                        Label("Loved Ones", systemImage: "person").font(.system(size: 80))
                    }
                ResourcesView(prompt: .resources).tag(4)
                    .tabItem {
                        Label("Resources", systemImage: "person").font(.system(size: 80))
                    }
            }
        }
        .toolbarBackground(Color(.capsuleLightPurple), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
    
}
