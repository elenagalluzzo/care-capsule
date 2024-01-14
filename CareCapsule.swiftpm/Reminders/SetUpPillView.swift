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
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                TextField("Medication Name", text: $pill.title)
                DatePicker("Please enter a date", selection: $pill.firstDate)
                    .labelsHidden()
                
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
