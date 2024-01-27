//
//  ResourcesView.swift
//
//
//  Created by Elena Galluzzo on 2024-01-10.
//

import SwiftUI

struct ResourcesView: View {
    @State var prompt: AssistantModels.Prompts?
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    List {
                        VStack {
                            Text("211")
                            Text("24 hour free and confidential service Canada's primary source of information for government and community-based health and social services that can be accessed by phone, text, chat, and online.")
                        }
                        VStack {
                            Text("call 1-866-585-0445")
                            Text("24 Hour Free Counselling with Wellness Together Canada")
                        }
                        
                        VStack {
                            Text("text WELLNESS to 741741")
                            Text("To connect with a mental health professional one-on-one:")
                        }
                        
                    }
                }
            }
            .background(Color("capsuleLightOrange").opacity(0.3))
            .navigationTitle("Resources")
            .background(Color("capsuleLightOrange").opacity(0.3))
            .scrollContentBackground(.hidden)
            .safeAreaInset(edge: .bottom, spacing: 5) {
                Group {
                    MiniAssistantHelperView(prompt: prompt, isTalking: true)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
            }
        }
        
        
    }
    
}

#Preview {
    ResourcesView()
}
