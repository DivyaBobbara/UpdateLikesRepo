//
//  CVCellViewModel.swift
//  UpdateLikesApiDataBinding
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
struct MemberCellViewModel:RowViewModel{
    let userName : String
    let totalLikes : Int
    let likeStatus : Bool
    let postId : Int
    let postData : String
    let isClicked : Observable<Bool>
    var updateButtonPressed : (()->Void)?
    
    init(userName:String,totalLikes : Int,likeStatus : Bool,postId : Int,postData : String,isClicked :Observable<Bool> = Observable(value: false),updateButtonPressed : (()->Void)? = nil){
        self.userName = userName
        self.totalLikes = totalLikes
        self.likeStatus = likeStatus
        self.postId = postId
        self.postData = postData
        self.isClicked = isClicked
        self.updateButtonPressed = updateButtonPressed
    }
}
