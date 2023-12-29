import SwiftUI

struct TabBarView: View {
    @State private var selection = 2
    var body: some View {
        TabView(selection: $selection) {
            Group {
                ReminderView(prompt: .reminderGeneral).tag(1)
                    .tabItem {
                        Label("Life Manager", systemImage: "person").font(.system(size: 80))
                    }
                
                AssistantPromptsView().tag(2)
                    .tabItem {
                        Label("Your Assistant", image: "Assistant-tab").font(.system(size: 80))
                    }
                
                
                PeopleView(prompt: .lovedOnesGeneral).tag(3)
                    .tabItem {
                        Label("Loved Ones", systemImage: "person").font(.system(size: 80))
                    }
            }
        }
        .toolbarBackground(Color(.capsuleLightPurple), for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
        
    }
    
}
