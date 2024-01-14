//
//  AssistantResponse.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI

struct AssistantResponse {
    func getAssistantResponse(message: String, negativesCount: Int, hasPeople: Bool) -> (response: String, prompt: AssistantModels.ResponsePrompts) {
        let lowercasedMessage = message.lowercased()
        let greetings: [String] = ["hello", "hi", "hey", "hello there", "hi there", "hey there", "greetings", "good morning", "good afternoon", "good evening"]
        let farewells: [String] = ["bye", "goodbye", "good bye", "see you", "talk to you later", "farewell", "goodnight", "good night", "bye bye"]
        let pillQuestions: [String] = ["pill", "medication", "med", "meds", "medicine", "drug"]
        let taskQuestions: [String] = ["task", "reminder", "appointment", "today"]
        let unrelatedQuestions: [String] = ["how", "who", "what", "when", "where", "why"]
        let generic: [String] = ["That's cool", "Tell me more", "That's interesting", "I see"]
        
        if negativesCount >= 3 {
            if hasPeople {
                return (response: "You seem upset. Perhaps reminding yourself of positive memories will uplift your mood.", prompt: .negative)
            } else {
                return (response: "You seem low in spirits. Perhaps you should talk to someone", prompt: .negative)
            }
        }
        
        if greetings.contains(lowercasedMessage) {
            return (response: "Hi there!", prompt: .none)
        } else if farewells.contains(lowercasedMessage) {
            return (response: "Goodbye!", prompt: .none)
        } else if lowercasedMessage.contains("how are you") || lowercasedMessage.contains("how's it going") {
            return (response: "I'm fine, how about you?", prompt: .none)
        } else if pillQuestions.contains(lowercasedMessage) {
            return (response: "To view your medication schedule, or to set up a medication reminder, press the 💊 emoji in the bottom left corner.", prompt: .none)
        } else if taskQuestions.contains(lowercasedMessage) {
            return (response: "To view or set up reminders, press the 💊 emoji in the bottom left corner.", prompt: .negative)
        } else if lowercasedMessage.contains("help") {
            return (response: "What do you need help with?", prompt: .negative)
//            if lowercasedMessage.contains("pills") || lowercasedMessage.contains("pills") {
//                return "Do you need help setting up a medication schedule?"
//                if lowercasedMessage.contains("no") {
//                    return "What do you need help with?"
//                }
//            }
        } else if unrelatedQuestions.contains(lowercasedMessage){
            return (response: "I am not sure… I am sorry.", prompt: .none)
        } else {
            return (response: generic.randomElement() ?? "I see", prompt: .none)
        }
    }
    
}
