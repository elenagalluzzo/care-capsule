//
//  AssistantPromptsView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI
import AVFoundation

struct AssistantPromptsView: View {
    @State var isTalking: Bool = true
    @State var synthesizer = AVSpeechSynthesizer()
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.capsuleLightOrange)
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    Text("Your Assistant")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.capsuleDarkPurple))
                        .padding()
                    Text("Hello, how can I help you?")
                        .font(.title)
                    Group {
                        if isTalking {
                            AssistantSpeechAnimation()
                        } else {
                            Image("Assistant-1")
                        }
                    }
                    .onAppear {
                        speak(text: "Hello, how can I help you?")
                        isTalking = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isTalking = false
                        }
                    }
                    .aspectRatio(3, contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(60)
                    HStack(spacing: 16) {
                        NavigationLink(destination: ReminderView(prompt: .tasksToday)) {
                            PromptButtonView(prompt: AssistantModels.Prompts.tasksToday.rawValue)
                        }
                        NavigationLink(destination: ReminderView(prompt: .setUpReminder)) {
                            PromptButtonView(prompt: AssistantModels.Prompts.setUpReminder.rawValue)
                        }
                    }
                    HStack(spacing: 16) {
                        NavigationLink(destination: ReminderView(prompt: .pillsToTake)) {
                            PromptButtonView(prompt: AssistantModels.Prompts.pillsToTake.rawValue)
                        }
                        NavigationLink(destination: PeopleView(prompt: .memories)) {
                            PromptButtonView(prompt: AssistantModels.Prompts.memories.rawValue)
                        }
                    }
                    NavigationLink(destination: AssistantChatView()) {
                        PromptButtonView(prompt: AssistantModels.Prompts.chat.rawValue)
                    }
                }
                .padding(16)
            }
        }
    }
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.synthesizer.speak(utterance)
    }
}

struct PromptButtonView: View {
    var prompt: String
    var body: some View {
        Text(prompt)
            .padding(10)
            .foregroundColor(Color(.capsuleDarkPurple))
            
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.capsuleDarkOrange), lineWidth: 2)
            ).background(RoundedRectangle(cornerRadius: 10).fill(Color(.capsuleLightOrange)))
        
            .font(.title3)
            .fontWeight(.bold)
            .lineLimit(5)
            .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    AssistantPromptsView()
}
