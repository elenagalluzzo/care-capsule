//
//  AssistantResponse.swift
//
//
//  Created by Elena Galluzzo on 2024-01-04.
//

import SwiftUI
import SwiftData

@MainActor
class AssistantResponse: ObservableObject {
    @Environment(\.modelContext) var modelContext
    @Published var message = ""
    @Published var chatMessages = [AssistantModels.ChatMessageModel]()
    @Published var isWaiting = false
    @Published var negativeCount = 0
    @Query var memories: [MemoryEntity]
    let defaults = UserDefaults.standard
    @State var isTalking: Bool = true
    
    func sendMessage(sentimentPrediction: String) async throws {
        let userMessage = AssistantModels.ChatMessageModel(speaker: .me, text: message)
        chatMessages.append(userMessage)
        isWaiting = true
        let response = getAssistantResponse(message: message, sentimentPrediction: sentimentPrediction, hasMemories: memories.count > 0)
        let assistantMessage = AssistantModels.ChatMessageModel(speaker: .assistant, text: response.response)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.chatMessages.append(assistantMessage)
        }
        message = ""
        isWaiting = false
    }
    
    func getAssistantResponse(message: String, sentimentPrediction: String, hasMemories: Bool) -> (response: String, prompt: AssistantModels.ResponsePrompts) {
        let trimmedMessage = message.trimmingCharacters(in: .whitespaces)
        let lowercasedMessage = trimmedMessage.lowercased()
        let greetings: [String] = ["hello", "hi", "hey", "hello there", "hi there", "hey there", "greetings", "good morning", "good afternoon", "good evening"]
        let farewells: [String] = ["bye", "goodbye", "good bye", "see you", "talk to you later", "farewell", "goodnight", "good night", "bye bye"]
        let pillQuestions: [String] = ["pill", "medication", "med", "meds", "medicine", "drug"]
        let taskQuestions: [String] = ["task", "reminder", "appointment", "today"]
        let resourceQuestions: [String] = ["resource", "mental health", "resources"]
        let memoryQuestions: [String] = ["memory", "memories", "album", "albums"]
        let unrelatedQuestions: [String] = ["how", "who", "what", "when", "where", "why"]
        let generic: [String] = ["Please tell me more", "I see", "How’s your day going so far?", "Is there I can help you with today?", "Do you need assistance?", "Thanks for providing that information.", "Could you please elaborate?"]
        let consideredRespondes: [String] = ["You seem low in spirits. You can seek information or help by calling or texting 211. There are more resources you can find in the resources tab below.", "You seem upset. Perhaps reminding yourself of positive memories will uplift your mood. You can seek information or help by calling or texting 211. You can also access mental health resources in the resources tab below."]
        
        
        if greetings.contains(lowercasedMessage) {
            return (response: "Hi there!", prompt: .none)
        } else if farewells.contains(lowercasedMessage) {
            return (response: "Goodbye!", prompt: .none)
        } else if lowercasedMessage.contains("how are you") || lowercasedMessage.contains("how's it going") {
            return (response: "I'm fine, how about you?", prompt: .none)
        } else if lowercasedMessage.contains("what's up") || lowercasedMessage.contains("whats up") {
               return (response: "I am here to assist you or to chat. How about you?", prompt: .none)
        } else if pillQuestions.contains(where: { lowercasedMessage.contains($0) }) {
            return (response: "To view your medication schedule, or to set up a medication reminder, press the Pills tab in the bottom left corner.", prompt: .none)
        } else if taskQuestions.contains(where: { lowercasedMessage.contains($0) }) {
            return (response: "To view or set up reminders, press the Tasks tab below.", prompt: .none)
        } else if resourceQuestions.contains(where: { lowercasedMessage.contains($0) }) {
            return (response: "To view mental health resources, press the Resources tab in the bottom right corner.", prompt: .none)
        } else if memoryQuestions.contains(where: { lowercasedMessage.contains($0) }) {
            return (response: "To view or set up good moments and memories, press the Memories tab.", prompt: .none)
        } else if lowercasedMessage.contains("help") {
            return (response: "What do you need help with?", prompt: .none)
    // sentiment analysis
        } else if sentimentPrediction == "considered" {
            negativeCount += 1
            defaults.set(negativeCount, forKey: "NegativeCount")
            if negativeCount > 10 {
                return (response: "You have been showing signs of poor mental health. Please call 1-866-585-0445 for free 24 Hour councelling. There are more resources you can find in the resources tab below.", prompt: .negative)
            }
            if memories.count > 0 {
                return (response: "You seem upset. Perhaps reminding yourself of positive memories will uplift your mood. You can also access mental health resources in the resources tab below.", prompt: .negative)
            } else {
                return (response: consideredRespondes.randomElement() ?? "You seem low in spirits. You can seek information or help by calling or texting 211. There are more resources you can find in the resources tab below.", prompt: .negative)
            }
        } else if unrelatedQuestions.contains(where: { lowercasedMessage.contains($0) }) {
            return (response: "I am not sure… I am sorry.", prompt: .none)
        } else {
            return (response: generic.randomElement() ?? "I see", prompt: .none)
        }
    }
}


