//
//  ContentView.swift
//  MyBlog
//
//  Created by Manoel Leal on 11/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var profilePosts = ProfilePosts()
    @State private var showingAddPost = false
    @State private var iconListShowing = true
    
    var body: some View {
        
        VStack{
            NavigationView{
                Group{
                    if profilePosts.posts.isEmpty{
                        Text("No posts")
                    } else{
                        List{
                            Section{
                                ForEach(profilePosts.posts) { post in
                                    NavigationLink{
                                        PostDetailsView(postDetail: post)
                                    } label: {
                                        VStack(alignment: .leading){
                                            Text("\(post.title) ")
                                                .font(.headline)
                                            Text("\(post.datePost.formatted(date: .abbreviated, time: .omitted))")
                                                .font(.footnote)
                                        }
                                    }
                                    
                                }
                                .onDelete(perform: removePost)
                            } header: {
                                if !profilePosts.posts.isEmpty{
                                    Text("Your Posts")
                                }
                                
                            }
                        
                        }

                    }
                }
                .navigationTitle("Blog")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingAddPost = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            iconListShowing.toggle()
                        } label: {
                            if iconListShowing{
                                Image(systemName: "list.dash")
                            } else {
                                Image(systemName: "rectangle.grid.2x2")
                            }
                        }
                    }

                }

                .sheet(isPresented: $showingAddPost){
                    AddPostView(profilePosts: profilePosts)
                }

            }
        }
    }
    
    func removePost(at offsets: IndexSet){
        profilePosts.posts.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
