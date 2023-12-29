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
        var status: Status?
        var checkBoxImageName: String?
    }
    
    struct TasksCellModel {
        var description: String?
        var title: String?
        var frequency: Frequency?
        var status: Status?
        var checkBoxImageName: String?
        var date: String?
    }
    
    enum Frequency: String {
        case once = "Once"
        case repeating = "Daily"
    }
    
    enum Status {
        case checked
        case unchecked
    }
    
}

