//
//  SetUpPillView.swift
//
//
//  Created by Elena Galluzzo on 2024-01-10.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct SetUpPillView: View {
    @Environment(\.modelContext) var modelContext
    
    @Binding var showSetUp: Bool
    
    @Bindable var pill: MedicationEntity = MedicationEntity()
    var body: some View {
        List {
            VStack {
                TextField("Medication Name", text: $pill.title)
                DatePicker("Please enter a date", selection: $pill.firstDate)
                    .labelsHidden()
                Picker("Frequency", selection: $pill.frequency) {
                    ForEach(ReminderModels.Frequency.allCases) { frequency in
                        Text(frequency.rawValue).tag(frequency.rawValue)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
                Button("Add") {
                    modelContext.insert(pill)
                    showSetUp = false
                }
            }
        }
    }
}

//#Preview {
//    SetUpPillView()
//        .modelContainer(for: MedicationEntity.self)
//}
