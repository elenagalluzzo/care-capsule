//
//  AssistantChatView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI
import AVFoundation
import CoreML

struct AssistantChatView: View {
    @StateObject private var viewModel = AssistantResponse()
    @State var isTalking: Bool = true
    @State var synthesizer = AVSpeechSynthesizer()
    @State private var sentimentPrediction = "notConsidered"
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    Group {
                        if isTalking {
                            AssistantSpeechAnimation()
                        } else {
                            Image("Assistant-1")
                        }
                    }
                    .onAppear {
                        speak(text: "Type in the textfield below.")
                        isTalking = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isTalking = false
                        }
                    }
                    .frame(width: 80, height: 80)
                    .scaleEffect(CGSize(width: 0.7, height: 0.7))
                    .padding()
                    .onDisappear {
                        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
                    }
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing:15) {
                                messageView(message: AssistantModels.ChatMessageModel(speaker: .assistant, text: "Press type in the textfield below."))
                                ForEach(viewModel.chatMessages) { message in
                                    messageView(message: message)
                                }
                                Color.clear
                                    .frame(height: 5)
                                    .id("bottom")
                            }
                            
                            
                        }
                        .onChange(of: viewModel.chatMessages.count, { _, _ in
                            proxy.scrollTo(viewModel.chatMessages[viewModel.chatMessages.count-1].id, anchor: .bottom)
                        })
                        .id("bottom")
                        Spacer()
                    }
                    Button("Dismiss Keyboard") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .foregroundColor(.white)
                    .tint(Color("capsuleMediumPurple"))
                    .buttonStyle(.borderedProminent)
                    HStack {
                        VStack {
                            TextField("Type here ...", text: $viewModel.message, axis: .vertical)
                                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 30))
                                .background(Color("capsuleLightOrange")
                                    .cornerRadius(20))
                        }
                        
                        if viewModel.isWaiting {
                            ProgressView()
                                .padding()
                        } else {
                            HStack {
                                Button("Send") {
                                    analyzeSentiment()
                                    sendMessage(sentimentPrediction: sentimentPrediction)
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                                .buttonStyle(.borderedProminent)
                                .controlSize(.large)
                                
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                }
                .background(Color("capsuleLightOrange").opacity(0.3))
            }
            .navigationTitle("Chat")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color("capsuleMediumPurple"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    func messageView(message: AssistantModels.ChatMessageModel) -> some View {
        HStack {
            if message.speaker == .me {
                Spacer(minLength: 100)
            }
            if !message.text.isEmpty {
                VStack {
                    Text(message.text)
                        .foregroundColor(message.speaker == .me ? Color(.black) : Color("capsuleDarkPurple"))
                        .font(.title3)
                        .padding(12)
                        .background(message.speaker == .me ? Color("capsuleLightOrange") : Color(.white))
                        .cornerRadius(16)
                        .overlay(alignment: message.speaker == .me ? .bottomTrailing : .bottomLeading) {
                            Text(message.speaker.rawValue.capitalized)
                                .font(.subheadline)
                                .offset(y: 35)
                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                        }
                }
            }
            if message.speaker == .assistant {
                Spacer(minLength: 100)
            }
        }
        .padding(.horizontal)
    }
    
    func sendMessage(sentimentPrediction: String) {
        Task {
            do {
                try await viewModel.sendMessage(sentimentPrediction: sentimentPrediction)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let last = viewModel.chatMessages.last {
                        speak(text: last.text)
                        isTalking = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isTalking = false
                        }
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        self.synthesizer.speak(utterance)
    }
    
    private func analyzeSentiment() {
        do {
            let model = try MentalHealthSentimentAnalysis(configuration: MLModelConfiguration())
            let input = MentalHealthSentimentAnalysisInput(text: viewModel.message)
            guard let output = try? model.prediction(input: input) else { return }
            sentimentPrediction = output.label == "0" ? "notConsidered" : "considered"
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    AssistantChatView()
}
