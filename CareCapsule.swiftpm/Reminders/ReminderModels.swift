//
//  ReminderModels.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct ReminderModels {
    
    enum Frequency: String, CaseIterable, Identifiable {
        case once = "once"
        case repeating = "repeating"
        var id: Frequency { self }
    }
    
}

