//
//  MiniAssistantHelperView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI
import AVFoundation

struct MiniAssistantHelperView: View {
    @State var prompt: AssistantModels.Prompts?
    @State var isTalking: Bool = true
    @State var synthesizer = AVSpeechSynthesizer()
    var body: some View {
        HStack (alignment: .bottom, spacing: 40) {
            Spacer()
            Group {
                if isTalking {
                    Text(assistantSpeech(prompt:prompt))
                        .padding()
                        .lineLimit(10)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("capsuleDarkPurple"), lineWidth: 2)
                        ).background(RoundedRectangle(cornerRadius: 10).fill(Color(.white)))
                    AssistantSpeechAnimation()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                        .frame(width: 20, height: 20)
                        .scaleEffect(CGSize(width: 0.7, height: 0.7))
                        .aspectRatio(1, contentMode: .fit)
                } else {
                    Image("Assistant-1")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                        .frame(width: 20, height: 20)
                        .scaleEffect(CGSize(width: 0.7, height: 0.7))
                        .aspectRatio(1, contentMode: .fit)
                        .onTapGesture {
                            isTalking = true
                            speak(text: assistantSpeech(prompt:prompt))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                self.isTalking = false
                            }
                        }
                }
            }
        }
        .onAppear {
            speak(text: assistantSpeech(prompt:prompt))
            isTalking = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.isTalking = false
            }
        }
        .onDisappear {
            synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
        .background(.clear)
    }
    func assistantSpeech(prompt: AssistantModels.Prompts?) -> String {
        switch prompt {
        case .tasksToday:
            return "Here are your tasks. "
        case .setUpReminder:
            return "Press the + next to tasks to add a new task."
        case .setUpPill:
            return "Press the + next to Medication to add a new medication schedule."
        case .pillsToTake:
            return "Here is the medication you need to take. Check the circle once you have taken them."
        case .memories:
            return "Here are your memories. Press plus to add a memory and the associated images."
        case .reminderGeneral:
            return "You can press the + next to tasks to set up a reminder."
        case .resources:
            return "Here are some mental health and support resources you can access."
        case .setUpImages:
            return "Press \"Add Images\" to add more images to this memory."
        default:
            return "Press 'Your Assistant' if you need assistance."
        }
    }
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.synthesizer.speak(utterance)

    }
}

