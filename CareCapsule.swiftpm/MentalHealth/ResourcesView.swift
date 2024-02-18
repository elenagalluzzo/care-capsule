//
//  ResourcesView.swift
//
//
//  Created by Elena Galluzzo on 2024-01-10.
//

import SwiftUI

struct ResourcesView: View {
    @State var prompt: AssistantModels.Prompts?
    var resources: [ResourcesModels.Resource] = [ResourcesModels.Resource(name: "211", description: "24 hour free and confidential service Canada's primary source of information for government and community-based health and social services that can be accessed by phone, text, chat, and online."), ResourcesModels.Resource(name: "Call 1-866-585-0445", description: "24 Hour Free Counselling with Wellness Together Canada"), ResourcesModels.Resource(name: "Text WELLNESS to 741741", description: "To connect with a mental health professional one-on-one")]
    var body: some View {
        NavigationStack {
            ZStack {
                VStack () {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    List {
                        ForEach(resources) { resource in
                            ResourceCell(name: resource.name, description: resource.description)
                        }
                   }
                }
            }
            .background(Color("capsuleLightOrange").opacity(0.3))
            .navigationTitle("Resources")
            .scrollContentBackground(.hidden)
            .safeAreaInset(edge: .bottom, spacing: 5) {
                Group {
                    MiniAssistantHelperView(prompt: prompt, isTalking: true)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color("capsuleMediumPurple"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


#Preview {
    ResourcesView()
}
