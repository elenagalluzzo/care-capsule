//
//  AssistantChatView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI

struct AssistantChatView: View {
    @StateObject private var viewModel = AssistantModels.ChatViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {           
                VStack {
                    Divider()
                        .background(Color(.capsuleLightPurple))
                    AssistantSpeechAnimation()
                        .frame(width: 80, height: 80)
                        .scaleEffect(CGSize(width: 0.7, height: 0.7))
                        .padding()
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing:15) {
                                ForEach(viewModel.chatMessages) { message in
                                    messageView(message: message)
                                }
                                Color.clear
                                    .frame(height: 2)
                                    .id("bottom")
                            }
                        }
                    }
                    Button("Dismiss Keyboard") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .foregroundColor(Color(.capsuleDarkOrange))
                    HStack {
                        VStack {
                            HStack {
                                TextField("Type or speak ...", text: $viewModel.message, axis: .vertical)
                                Image(systemName: "mic.fill")
                            }
                            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 30))
                            .background(Color(.capsuleLightPurple)
                                .cornerRadius(20))
                        }
                        
                        if viewModel.isWaiting {
                            ProgressView()
                                .padding()
                        } else {
                            HStack {
                                Button("Send") {
                                    sendMessage()
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                }
                .background(Color.white)
            }
            .navigationTitle("Chat")
            .background(Color(.capsuleLightPurple))
        }
        
    }
        
    func messageView(message: AssistantModels.ChatMessageModel) -> some View {
        HStack {
            if message.speaker == .me {
                Spacer(minLength: 60)
            }
            if !message.text.isEmpty {
                VStack {
                    Text(message.text)
                        .foregroundColor(message.speaker == .me ? Color(.capsuleDarkPurple) : .black)
                        .padding(12)
                        .background(message.speaker == .me ? Color(.capsuleLightPurple) : .gray)
                        .cornerRadius(16)
                    
                    Text(message.speaker.rawValue.capitalized)
                        .font(.caption)
                        .offset(y: 0)
                }
            }
            if message.speaker == .assistant {
                Spacer(minLength: 60)
            }
        }
        .padding(.horizontal)
    }
       
    func sendMessage() {
        Task {
            do {
                try await viewModel.sendMessage()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AssistantChatView()
}
