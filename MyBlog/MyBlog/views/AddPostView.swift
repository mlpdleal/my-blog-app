//
//  AddPostView.swift
//  MyBlog
//
//  Created by Manoel Leal on 11/06/22.
//

import SwiftUI

struct AddPostView: View {
    
    @ObservedObject var profilePosts: ProfilePosts
    @Environment(\.dismiss) var dismiss
    
   
    @State private var title = ""
    @State private var description = ""
    @State private var image = "nothing"
    
    let images = ["canada", "city", "lake", "nature", "road", "sunset", "trees"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Title", text: $title)
                        .disableAutocorrection(false)
                        .keyboardType(.default)
                    TextField("Description", text: $description)
                        .disableAutocorrection(false)
                        .keyboardType(.default)


                } header: {
                    Text("Main Information")
                }
                
                
                Section{
                    Picker("Image", selection: $image){
                        ForEach(images, id: \.self){
                            Text($0)
                        }
                    }
                    
                    Image(image)
                        .resizable()
                        .scaledToFit()
                } header: {
                    Text("Select Image theme")
                }
            }
            .navigationTitle("Add Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(){
                Button("Save"){
                    let post = PostItem(title: title, description: description, image: image)
                    profilePosts.posts.append(post)
                    dismiss()
                }
            }
        }
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView(profilePosts: ProfilePosts())
    }
}
