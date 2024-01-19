//
//  ReminderModels.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct ReminderModels {
    
    struct PillCellModel {
        var frequency: Frequency?
        var medication: String?
        var checked: Bool
        var date: Date
    }
    
    struct TasksCellModel {
        var description: String?
        var title: String?
        var frequency: Frequency?
        var checked: Bool
        var date: Date
    }
    
    enum Frequency: String {
        case once = "Once"
        case repeating = "Repeating"
    }
    
}

