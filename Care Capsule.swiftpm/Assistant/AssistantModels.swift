//
//  AssistantModels.swift
//
//
//  Created by Elena Galluzzo on 2023-12-27.
//

import Foundation

struct AssistantModels {
    
    enum Prompts: String {
        case tasksToday = "What do I have going on today?"
        case setUpReminder = "Help me set up a reminder."
        case pillsToTake = "Have I taken my pills today?"
        case memories = "I want to see my memories."
        case chat = "I want to chat."
        case reminderGeneral
        case lovedOnesGeneral
    }
    
    struct ChatMessageModel: Identifiable {
        var id = UUID()
        var speaker: Speaker
        var text: String
        init(speaker: Speaker, text: String) {
            self.speaker = speaker
            self.text = text
        }
    }

    enum Speaker: String {
        case me
        case assistant
    }
    
    @MainActor
    class ChatViewModel: ObservableObject {
        @Published var message = ""
        @Published var chatMessages = [ChatMessageModel]()
        @Published var isWaiting = false
        func sendMessage() async throws {
            let userMessage = ChatMessageModel(speaker: .me, text: message)
            chatMessages.append(userMessage)
            isWaiting = true
            let assistantMessage = ChatMessageModel(speaker: .assistant, text: "")
            chatMessages.append(assistantMessage)
            message = ""
            isWaiting = false
        }
    }

}
