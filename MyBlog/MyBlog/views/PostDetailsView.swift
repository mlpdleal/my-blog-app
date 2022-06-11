//
//  PostDetailsView.swift
//  MyBlog
//
//  Created by Manoel Leal on 11/06/22.
//

import SwiftUI

struct PostDetailsView: View {
    
    let postDetail: PostItem
    
    var body: some View {
        ScrollView{
            VStack{
                Image(postDetail.image)
                    .resizable()
                    .scaledToFit()
                
                Text(postDetail.title)
                    .font(.title)
                    .padding()
                
                Text(postDetail.description)
                    .font(.body)
                    .padding()
                
                Text("By Sysadmin - \(postDetail.datePost.formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .frame(alignment: .leading)
                    .padding()
            }
        }
    }
}

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let profilePosts = ProfilePosts()
        
        PostDetailsView(postDetail: profilePosts.posts[0])
    }
}
