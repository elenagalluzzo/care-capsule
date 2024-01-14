//
//  CheckboxView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct CheckboxView: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundColor(.orange)
                .onTapGesture { configuration.isOn.toggle() }
            configuration.label
        }
    }
}
