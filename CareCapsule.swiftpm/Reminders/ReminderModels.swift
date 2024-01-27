//
//  ReminderModels.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct ReminderModels {
    
//    struct PillCellModel {
//        var frequency: String?
//        var medication: String?
//        var checked: Bool
//        var date: Date
//    }
    
    struct TasksCellModel {
        var description: String?
        var title: String?
        var frequency: Frequency?
        var checked: Bool
        var date: Date
    }
    
    enum Frequency: String, CaseIterable, Identifiable {
        case once = "once"
        case repeating = "repeating"
        var id: Frequency { self }
    }
    
}

