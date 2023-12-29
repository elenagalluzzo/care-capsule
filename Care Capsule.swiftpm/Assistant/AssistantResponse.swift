//
//  AssistantResponse.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import SwiftUI

struct AssistantResponse {
    func getBotResponse(message: String) -> String {
        let lowercasedMessage = message.lowercased()
        let greetings: [String] = ["hello", "hi", "hey", "hello there", "hi there", "hey there", "greetings", "good morning", "good afternoon", "good evening"]
        let farewells: [String] = ["bye", "goodbye", "good bye", "see you", "talk to you later", "farewell", "goodnight", "good night", "bye bye"]
        let unrelatedQuestions: [String] = ["how", "who", "what", "when", "where", "why"]
        let generic: [String] = ["That's cool", "Tell me more", "That's interesting", "I see"]
        let negativesCount: Int = 0
        let hasPeople: Bool = false
        
        if negativesCount >= 3 {
            if hasPeople {
                return "You seem upset. Perhaps reminding yourself of positive memories will uplift your mood."
            } else {
                return "You seem low in spirits. Perhaps you should talk to someone"
            }
        }
        
        if greetings.contains(lowercasedMessage) {
            return "Hi there!"
        } else if farewells.contains(lowercasedMessage) {
            return "Goodbye!"
        } else if lowercasedMessage.contains("how are you") || lowercasedMessage.contains("how's it going") {
            return "I'm fine, how about you?"
        } else if lowercasedMessage.contains("help") {
            return "What do you need help with?"
            if lowercasedMessage.contains("pills") || lowercasedMessage.contains("pills") {
                return "Do you need help setting up a medication schedule?"
                if lowercasedMessage.contains("no") {
                    return "What do you need help with?"
                }
            }
        } else if unrelatedQuestions.contains(lowercasedMessage){
            return "I am not sure… I am sorry."
        } else {
            return generic.randomElement() ?? "I see"
        }
    }
    
    
}
