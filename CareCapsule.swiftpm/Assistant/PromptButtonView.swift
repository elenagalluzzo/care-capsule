//
//  PromptButtonView.swift
//
//
//  Created by Elena Galluzzo on 2024-01-31.
//

import SwiftUI

struct PromptButtonView: View {
    var prompt: String
    var body: some View {
        Text(prompt)
            .padding(10)
            .foregroundColor(Color(.black))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(prompt == "I want to chat." ? Color("capsuleDarkPurple") : Color("capsuleDarkOrange") , lineWidth: 2)
                    
            ).background(RoundedRectangle(cornerRadius: 10).fill(prompt == "I want to chat." ? Color("capsuleLightPurple") : Color("capsuleLightOrange")))
            .multilineTextAlignment(.center)
            .font(.title2)
            .fontWeight(prompt == "I want to chat." ? .semibold : .regular)
            .fixedSize(horizontal: false, vertical: true)
            .accessibilityAddTraits(.isButton)
    }
}


#Preview {
    PromptButtonView(prompt: "I want to chat.")
}
