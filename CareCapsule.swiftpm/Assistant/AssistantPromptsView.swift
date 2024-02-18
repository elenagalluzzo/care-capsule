//
//  AssistantPromptsView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI
import AVFoundation
import SwiftData

@available(iOS 17.0, *)
struct AssistantPromptsView: View {
    @Binding var selection: Tab
    @State var isTalking: Bool = true
    @State var synthesizer = AVSpeechSynthesizer()
    @EnvironmentObject var pillsViewModel: PillsViewModel
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State private var showSetUp: Bool = false
    @Query var pills: [MedicationEntity]
    var body: some View {
        NavigationStack() {
            ZStack {
                Color("capsuleLightOrange")
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 16) {
                    Spacer(minLength: 40)
                    Text("Your Assistant")
                        .fontWeight(.bold)
                        .foregroundColor(Color("capsuleDarkPurple"))
                        .font(.system(size: 45))
                        .padding()
                    Text("Hello, how can I help you?")
                        .font(.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("capsuleDarkPurple"), lineWidth: 2)
                        ).background(RoundedRectangle(cornerRadius: 10).fill(Color(.white)))
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
                    .onDisappear {
                        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                    }
                    HStack(spacing: 16) {
                        PromptButtonView(prompt: AssistantModels.Prompts.pillsToTake.rawValue)
                            .onTapGesture {
                                if pills.count == 0 {
                                    pillsViewModel.pillsPrompt = .setUpPill
                                } else {
                                    pillsViewModel.pillsPrompt = .pillsToTake
                                }
                                self.selection = Tab.pills
                            }
                        PromptButtonView(prompt: AssistantModels.Prompts.setUpReminder.rawValue)
                            .onTapGesture {
                                taskViewModel.taskPrompt = .setUpReminder
                                self.selection = Tab.tasks
                            }
                    }
                    HStack(spacing: 16) {
                        PromptButtonView(prompt: AssistantModels.Prompts.memories.rawValue)
                            .onTapGesture {
                                self.selection = Tab.memories
                            }
                        PromptButtonView(prompt: AssistantModels.Prompts.resources.rawValue)
                            .onTapGesture {
                                self.selection = Tab.resources
                            }
                    }
                    NavigationLink(destination: AssistantChatView()) {
                        PromptButtonView(prompt: AssistantModels.Prompts.chat.rawValue)
                    }
                    Spacer(minLength: 40)
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


