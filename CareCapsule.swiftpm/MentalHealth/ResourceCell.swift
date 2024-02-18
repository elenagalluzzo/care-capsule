//
//  ResourceCell.swift
//
//
//  Created by Elena Galluzzo on 2024-01-31.
//

import SwiftUI

struct ResourceCell: View {
    var name: String
    var description: String
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("capsuleDarkPurple"))
                    .multilineTextAlignment(.center)
                Text(description)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
    }
}

#Preview {
    ResourceCell(name: "211", description: "24 hour free and confidential service Canada's primary source of information for government and community-based health and social services that can be accessed by phone, text, chat, and online.")
}
