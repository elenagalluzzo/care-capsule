//
//  PeopleView.swift
//
//
//  Created by Elena Galluzzo on 2023-12-28.
//

import SwiftUI

struct PeopleView: View {
    @State var prompt: AssistantModels.Prompts?
    var people: [PeopleModels.CellModel] = [PeopleModels.CellModel(name: "hehe", profileImageName: "Assistant-1", images: [PeopleModels.Image(imageName: "Assistant-1", imageDescription: "Lovely times"), PeopleModels.Image(imageName: "Assistant-1", imageDescription: "Lovely times"), PeopleModels.Image(imageName: "Assistant-1", imageDescription: "Lovely times")]), PeopleModels.CellModel(name: "hehe", profileImageName: "Assistant-1", images: [PeopleModels.Image(imageName: "Assistant-1", imageDescription: "Lovely times")])]
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Divider()
                        .background(Color("capsuleLightPurple"))
                    List {
                        ForEach(people) { person in
                            PeopleCellView(person: PeopleModels.CellModel(name: person.name, profileImageName: person.images?[0].imageName ?? "Assistant-1", images: person.images))
                                .listRowBackground(Color("capsuleLightOrange"))
                           
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                .safeAreaInset(edge: .bottom, spacing: 5) {
                    MiniAssistantHelperView(prompt: prompt, isTalking: true)
             
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
                    
                }
                
                .background(Color("capsuleLightOrange").opacity(0.3))
            }
            .navigationTitle("Loved Ones")
            
        }
    }
}

struct PeopleCellView: View {
    var person: PeopleModels.CellModel
    var body: some View {
        NavigationLink(destination: PersonGalleryView(person: person)) {
            VStack {
                HStack {
                    Image(person.profileImageName ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .cornerRadius(5)
                        .padding(.leading, 8)
                    Text(person.name)
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct PersonGalleryView: View {
    @State var person: PeopleModels.CellModel
    var body: some View {
        NavigationStack {
            VStack {
                Text(person.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(person.images ?? []) { image in
                            VStack {
                                Image(image.imageName ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .padding(.horizontal, 20)
                                Text(image.imageDescription ?? "")
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PeopleView()
}
