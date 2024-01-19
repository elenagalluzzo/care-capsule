//
//  AssistantResponse.swift
//
//
//  Created by Elena Galluzzo on 2024-01-04.
//

import SwiftUI

@MainActor
class AssistantResponse: ObservableObject {
    @Published var message = ""
    @Published var chatMessages = [AssistantModels.ChatMessageModel]()
    @Published var isWaiting = false
    @State var isTalking: Bool = true
    
    func sendMessage(sentimentPrediction: String) async throws {
        let userMessage = AssistantModels.ChatMessageModel(speaker: .me, text: message)
        chatMessages.append(userMessage)
        isWaiting = true
        let response = getAssistantResponse(message: message, sentimentPrediction: sentimentPrediction, hasPeople: false)
        let assistantMessage = AssistantModels.ChatMessageModel(speaker: .assistant, text: response.response)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.chatMessages.append(assistantMessage)
        }
        message = ""
        isWaiting = false
    }
    
    func getAssistantResponse(message: String, sentimentPrediction: String, hasPeople: Bool) -> (response: String, prompt: AssistantModels.ResponsePrompts) {
        let trimmedMessage = message.trimmingCharacters(in: .whitespaces)
        let lowercasedMessage = trimmedMessage.lowercased()
        let greetings: [String] = ["hello", "hi", "hey", "hello there", "hi there", "hey there", "greetings", "good morning", "good afternoon", "good evening"]
        let farewells: [String] = ["bye", "goodbye", "good bye", "see you", "talk to you later", "farewell", "goodnight", "good night", "bye bye"]
        let pillQuestions: [String] = ["pill", "medication", "med", "meds", "medicine", "drug"]
        let taskQuestions: [String] = ["task", "reminder", "appointment", "today"]
        let unrelatedQuestions: [String] = ["how", "who", "what", "when", "where", "why"]
        let generic: [String] = ["That's cool", "Tell me more", "That's interesting", "I see"]
        
        if greetings.contains(lowercasedMessage) {
            return (response: "Hi there!", prompt: .none)
        } else if farewells.contains(lowercasedMessage) {
            return (response: "Goodbye!", prompt: .none)
        } else if lowercasedMessage.contains("how are you") || lowercasedMessage.contains("how's it going") {
            return (response: "I'm fine, how about you?", prompt: .none)
        } else if lowercasedMessage.contains("what's up") || lowercasedMessage.contains("whats up") {
               return (response: "I am here to assist you or to chat. How about you?", prompt: .none)
        } else if pillQuestions.contains(lowercasedMessage) {
            return (response: "To view your medication schedule, or to set up a medication reminder, press the 💊 emoji in the bottom left corner.", prompt: .none)
        } else if taskQuestions.contains(lowercasedMessage) {
            return (response: "To view or set up reminders, press the 💊 emoji in the bottom left corner.", prompt: .none)
        } else if lowercasedMessage.contains("help") {
            return (response: "What do you need help with?", prompt: .none)
        // sentiment analysis
        } else if sentimentPrediction == "considered" {
            if hasPeople {
                return (response: "You seem upset. Perhaps reminding yourself of positive memories will uplift your mood.", prompt: .negative)
            } else {
                return (response: "You seem low in spirits. Perhaps you should talk to someone", prompt: .negative)
            }
        } else if unrelatedQuestions.contains(lowercasedMessage){
            return (response: "I am not sure… I am sorry.", prompt: .none)
        } else {
            return (response: generic.randomElement() ?? "I see", prompt: .none)
        }
    }
}


