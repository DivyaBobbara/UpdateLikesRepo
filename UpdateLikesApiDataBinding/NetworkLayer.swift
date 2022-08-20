//
//  NetworkLayer.swift
//  UpdateLikesApiDataBinding
//
//  Created by Naga Divya Bobbara on 19/08/22.
//

import Foundation
import Alamofire
class NetworkLayer{
    var viewModel : GetPostsListViewModel{
        return GetPostsListViewModel()
    }
    lazy var controller : CVListViewController = {
        return CVListViewController()
    }()
    func apiCall()
    {
        DispatchQueue.global().async {
//            sleep(2)
            AF.request("http://stagetao.gcf.education:3000/api/v1/posts/3", method: .get, parameters: nil,headers: nil).responseDecodable(of: GetPosts.self) { response in
//                print(response)
                self.viewModel.isLoading.value = false
                self.viewModel.isTableViewHidden.value = false
                self.viewModel.title.value = " Get Posts"
                self.convertDataObjectToViewModel(response: response.value?.data ?? [])
                
               
            }
        
            
        }
    }
  
    
    func convertDataObjectToViewModel(response: [GetPostsData]) {
        self.viewModel.userLists.value = response.compactMap({
            MemberCellViewModel(userName: $0.userName ?? "",totalLikes: $0.totalLikes ?? 0,likeStatus: ($0.likeStatus)!,postId: $0.postId ?? 0,postData: $0.postData ?? "")
        })
    }
    
}
