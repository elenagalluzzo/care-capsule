//
//  TaskViewModel.swift
//
//
//  Created by Elena Galluzzo on 2024-02-04.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var taskPrompt = AssistantModels.Prompts.reminderGeneral
}
