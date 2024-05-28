//
//  HomeViewModel.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Variables
    
    private var arrPosts: [PostModel] = []
    var updateEventHandler: ((_ event: ViewUpdateState) -> Void)?
    var currentPage = 1
    var isPaginating = false
    // we are not getting total count value from api so that taking this bool to identify if there are more post available.
    var maxPostLimitReached = false
    
    // MARK: - API
    
    /// get post list api
    func getPostListAPI() {
        guard !isPaginating,
              !maxPostLimitReached else {
            return
        }
        isPaginating = true
        updateEventHandler?(.loading)
        let parameters = ["_page": currentPage, "_limit": 10]
        AlamofireApiService.shared().requestFor(modelType: [PostModel].self, apiType: ApiTypeConfiguration.getUserPost, param: parameters) { [weak self]
            response in
            guard let weakSelf = self else {
                return
            }
            Logger.log("currentPage: \(weakSelf.currentPage)")
            Logger.log("Response: \(response)")
            weakSelf.isPaginating = false
            switch response {
            case .success(let list):
                if list.count > 0 {
                    weakSelf.currentPage += 1
                    weakSelf.arrPosts.append(contentsOf: list)
                } else {
                    Logger.log("No More Data ")
                    weakSelf.maxPostLimitReached = true
                }
                weakSelf.updateEventHandler?(.success)
            case .failure(let error):
                weakSelf.updateEventHandler?(.failedAF(error))
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// get post
    /// - Parameter index: index value
    /// - Returns: post model contains post details like id, title etc..
    func getPost(index: Int) -> PostModel? {
        guard index < arrPosts.count else {
            return nil
        }
        return arrPosts[index]
    }
    
    /// number of rows
    var numberOfRows: Int {
        return arrPosts.count
    }
}

extension HomeViewModel {
    enum ViewUpdateState {
        case loading
        case success
        case failedAF(Error?)
        case reloadTableView
    }
}
