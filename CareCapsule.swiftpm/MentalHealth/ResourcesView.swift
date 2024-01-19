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
                        .background(Color(.capsuleLightPurple))
                    List {
                        VStack {
                            Text("211")
                            Text("211 is a free and confidential service that can be accessed by phone, text, chat, and online for information on government and community-based, non-clinical health and social services.")
                        }
                        VStack {
                            Text("call 1-866-585-0445")
                            Text("211 is a free and confidential service that can be accessed by phone, text, chat, and online for information on government and community-based, non-clinical health and social services.")
                        }
                        
                        VStack {
                            Text("text WELLNESS to 741741")
                            Text("211 is a free and confidential service that can be accessed by phone, text, chat, and online for information on government and community-based, non-clinical health and social services.")
                        }
                        
                    }
                }
            }
            .background(Color(.capsuleLightOrange).opacity(0.3))
            .navigationTitle("Resources")
            .background(Color(.capsuleLightOrange).opacity(0.3))
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
