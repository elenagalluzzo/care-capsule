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
//    @State private var pill = MedicationEntity()
    
    @Bindable var pill: MedicationEntity = MedicationEntity()
    var body: some View {
        List {
//            Color.black
//                .opacity(0.5)
//                .ignoresSafeArea()
            VStack {
                TextField("Medication Name", text: $pill.title)
                DatePicker("Please enter a date", selection: $pill.firstDate)
                    .labelsHidden()
                Picker("Priority", selection: $pill.frequency) {
                    Text(ReminderModels.Frequency.once.rawValue).tag(ReminderModels.Frequency.once)
                    Text(ReminderModels.Frequency.repeating.rawValue).tag(ReminderModels.Frequency.repeating)
                }
                .pickerStyle(.segmented)
                
                Button("Add") {
                    modelContext.insert(pill)
                }
            }
        }
    }
}

#Preview {
    SetUpPillView()
        .modelContainer(for: MedicationEntity.self)
}
