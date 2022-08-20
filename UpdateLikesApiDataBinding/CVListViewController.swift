//
//  CVListViewController.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
import Alamofire
class CVListViewController{
    let viewModel  : GetPostsListViewModel
  
    init(viewModel : GetPostsListViewModel = GetPostsListViewModel()){
        self.viewModel = viewModel
       
    }
    
    func start()
    {
        viewModel.isLoading.value = true
        viewModel.isTableViewHidden.value = true
        viewModel.title.value = "Loading...."
        apiCall { getPostsData in
            self.viewModel.isLoading.value = false
            self.viewModel.isTableViewHidden.value = false
            self.viewModel.title.value = " Get Posts"
            self.buildViewModels(data: getPostsData ?? [])
        }
//        updatePostsApiCall(postId: viewModel.userLists.value)
       
    }
    func apiCall(completion:@escaping([GetPostsData]?)->Void)
    {
        DispatchQueue.global().async {
//            sleep(1)
            AF.request("http://stagetao.gcf.education:3000/api/v1/posts/3", method: .get, parameters: nil,headers: nil).responseDecodable(of: GetPosts.self) { response in
                self.convertDataObjectToViewModel(response: response.value?.data ?? [])
                completion(response.value?.data)
               
            }
        
            
        }
    }
    func buildViewModels(data:[GetPostsData]){
        
        print(data[0].userName)
        for memberData in data {
            if let memberFeed = memberData as? GetPostsData{
                var memberCellVM : MemberCellViewModel = MemberCellViewModel(userName: memberFeed.userName ?? "", totalLikes: memberFeed.totalLikes ?? 0, likeStatus: (memberFeed.likeStatus)!, postId: memberFeed.postId ?? 0, postData: memberFeed.postData ?? "")
                memberCellVM.updateButtonPressed = handleUpdateLikes(postId: memberFeed.postId ?? 0, likeStatus: memberFeed.likeStatus!, viewModel: memberCellVM)
//                print("pressedbtn")
                
            }
        }
        
        
        
    }
    func handleUpdateLikes(postId : Int,likeStatus : Bool,viewModel : MemberCellViewModel) -> (()->Void){
        return {
        print(postId, likeStatus)
        }
    }
  
    
    func convertDataObjectToViewModel(response: [GetPostsData]) {
        self.viewModel.userLists.value = response.compactMap({
            MemberCellViewModel(userName: $0.userName ?? "",totalLikes: $0.totalLikes ?? 0,likeStatus: ($0.likeStatus)!,postId: $0.postId ?? 0,postData: $0.postData ?? "")
            
        })
//        print("userlist",viewModel.userLists.value[0].userName)
    }
//    func updateLikes(index:Int){
//        print("ulist",viewModel.userLists.value)
//        print("index",index)
//        let likeStatus = viewModel.userLists.value[index].likeStatus
//        let postId = viewModel.userLists.value[index].postId
//        print(likeStatus)
//        print(postId)
//        AF.request("http://stagetao.gcf.education:3000/api/v1/postLikes/\(postId)/3/\(!(likeStatus))", method: .put, parameters: nil, headers: nil).responseDecodable(of:UpdateLikes.self) { res in
////            print(res)
//        }
//    }
    
}
