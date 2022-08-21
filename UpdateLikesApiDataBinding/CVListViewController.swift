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
    let networkLayer : NetworkLayer
    init(viewModel : GetPostsListViewModel = GetPostsListViewModel(),networkLayer:NetworkLayer = NetworkLayer()){
        self.viewModel = viewModel
        self.networkLayer = networkLayer
    }
    func start()
    {
        viewModel.isLoading.value = true
        viewModel.isTableViewHidden.value = true
        viewModel.title.value = "Loading...."
        networkLayer.apiCall { getPostsData in
            self.viewModel.isLoading.value = false
            self.viewModel.isTableViewHidden.value = false
            self.viewModel.title.value = " Get Posts"
            self.buildViewModels(data: getPostsData ?? [])
        }
//        updatePostsApiCall(postId: viewModel.userLists.value)
    }
    func buildViewModels(data:[GetPostsData]){
        
//        print(data[0].userName)
        var rowViewModel = [MemberCellViewModel]()
        for memberData in data {
                var memberCellVM : MemberCellViewModel = MemberCellViewModel(userName: memberData.userName ?? "", totalLikes: memberData.totalLikes ?? 0, likeStatus: (memberData.likeStatus)!, postId: memberData.postId ?? 0, postData: memberData.postData ?? "")
                memberCellVM.likesButtonPressed = handleUpdateLikes(postId: memberData.postId ?? 0, likeStatus: memberData.likeStatus!, viewModel: memberCellVM)
               
                rowViewModel.append(memberCellVM)
                
            }
            self.viewModel.userLists.value = rowViewModel
        }
        
    func handleUpdateLikes(postId : Int,likeStatus : Bool,viewModel : MemberCellViewModel) -> (()->Void){
        return {
            self.networkLayer.updateLikes(postId: postId, likeStatus: likeStatus) { success in
                print("success")
                self.start()
            }
        }
    }
}
    

    
    
  
    
//    func convertDataObjectToViewModel(response: [GetPostsData]) {
//        self.viewModel.userLists.value = response.compactMap({
//            MemberCellViewModel(userName: $0.userName ?? "",totalLikes: $0.totalLikes ?? 0,likeStatus: ($0.likeStatus)!,postId: $0.postId ?? 0,postData: $0.postData ?? "")
//            
//        })
////        print("userlist",viewModel.userLists.value[0].userName)
//    }
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
    

