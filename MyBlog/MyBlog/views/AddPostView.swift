//
//  AddPostView.swift
//  MyBlog
//
//  Created by Manoel Leal on 11/06/22.
//

import SwiftUI

struct AddPostView: View {
    
    enum FocusedField{
        case title, description, image
    }
    
    @ObservedObject var profilePosts: ProfilePosts
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var image = "nothing"
    
    @FocusState private var fieldFocus: FocusedField?
    
    let images = ["canada", "city", "lake", "nature", "road", "sunset", "trees"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title", text: $title)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                        .focused($fieldFocus, equals: .title)
                        .submitLabel(.next)
                    TextField("Description", text: $description)
                        .disableAutocorrection(false)
                        .keyboardType(.default)
                        .focused($fieldFocus, equals: .description)
                        .submitLabel(.next)
                      

                } header: {
                    Text("Main Information")
                }
                
                
                Section{
                    Picker("Image", selection: $image){
                        ForEach(images, id: \.self){
                            Text($0)
                        }
                    }
                    .focused($fieldFocus, equals: .image)
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                } header: {
                    Text("Select Image theme")
                }
            }
            .onSubmit {
                switchField(currentField: fieldFocus ?? .title)
            }
            .navigationTitle("Add Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(){
                Button("Save"){
                    let post = PostItem(title: title, description: description, image: image)
                    profilePosts.posts.append(post)
                    dismiss()
                }
                .disabled(validateFields())
            }

        }
    }
    
    func validateFields() -> Bool{
        return title.isEmpty || description.isEmpty || description.count < 10
    }
    
    func switchField(currentField: FocusedField){
        switch currentField{
        case .title:
            fieldFocus = .description
        case .description:
            fieldFocus = .image
        case .image:
            fieldFocus = .title
        }
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(profilePosts: ProfilePosts())
    }
}
