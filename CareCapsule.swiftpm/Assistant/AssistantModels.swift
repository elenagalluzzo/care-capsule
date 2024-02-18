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
        case pillsToTake = "What pills do I have to take?"
        case memories = "I want to see my memories."
        case chat = "I want to chat."
        case resources
        case reminderGeneral
        case lovedOnesGeneral
        case setUpPill
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
    
    enum ResponsePrompts {
        case tasks
        case reminders
        case negative
        case all
        case none
    }
    
}
