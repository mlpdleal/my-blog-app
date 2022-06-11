//
//  PostItem.swift
//  MyBlog
//
//  Created by Manoel Leal on 11/06/22.
//

import Foundation

struct PostItem: Equatable, Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    let image: String
    var datePost = Date.now
}
