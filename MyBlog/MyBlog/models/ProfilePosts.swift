//
//  ProfilePosts.swift
//  MyBlog
//
//  Created by Manoel Leal on 11/06/22.
//

import Foundation

class ProfilePosts: ObservableObject{
    @Published var posts = [PostItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(posts){
                UserDefaults.standard.set(encoded, forKey: "posts")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "posts"){
            if let decodedItems = try? JSONDecoder().decode([PostItem].self, from: savedItems){
                posts = decodedItems
                return
            }
        }
        
        posts = []
    }
}
