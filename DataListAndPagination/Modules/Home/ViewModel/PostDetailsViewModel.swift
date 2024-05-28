//
//  PostDetailsViewModel.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import Foundation

class PostDetailsViewModel {
    
    // MARK: - Variables
    
    var postModel: PostModel?
    
    /// initializer
    /// - Parameter postModel: post model contains post details like id, title etc..
    init(postModel: PostModel? = nil) {
        self.postModel = postModel
    }
}
