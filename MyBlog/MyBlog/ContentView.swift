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
    @State private var showingGrid = false
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    
    ]
    
    
    var body: some View {
        
        VStack{
            NavigationView{
                Group{
                    if profilePosts.posts.isEmpty{
                        Text("No posts")
                    } else{
                        
                        if showingGrid{
                            ScrollView{
                                LazyVGrid(columns: columns){
                                    ForEach(profilePosts.posts){ post in
                                        NavigationLink{
                                            PostDetailsView(postDetail: post)
                                        } label: {
                                            VStack{
                                                Image(post.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    
                                                VStack{
                                                    Text(post.title)
                                                        .font(.headline)
                                                        .foregroundColor(Color("TextColor"))
                                                    
                                                    Text(post.datePost.formatted(date: .abbreviated, time: .omitted))
                                                        .font(.caption)
                                                        .foregroundColor(Color("TextColor"))
                                                }
                                                .frame(maxWidth: .infinity)
                                            }
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("TextColor"))
                                                    .opacity(0.3)
                                                
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                        } else {
                            List{
                                Section{
                                    ForEach(profilePosts.posts) { post in
                                        NavigationLink{
                                            PostDetailsView(postDetail: post)
                                        } label: {
                                            HStack{
                                                Image(post.image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 75, height: 75)
                                                
                                                VStack(alignment: .leading){
                                                    Text("\(post.title) ")
                                                        .font(.headline)
                                                    Text("\(post.datePost.formatted(date: .abbreviated, time: .omitted))")
                                                        .font(.footnote)
                                                }
                                            }
                                            
                                        }
                                        
                                    }
                                    .onDelete(perform: removePost)
                                } header: {
                                    if !profilePosts.posts.isEmpty{
                                        Text("My Posts")
                                    }
                                    
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
                            showingGrid.toggle()
                        } label: {
                            if showingGrid{
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
