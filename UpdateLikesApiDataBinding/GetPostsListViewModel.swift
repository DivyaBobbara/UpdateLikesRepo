//
//  GetPostsListViewModel.swift
//  UpdateLikesApiDataBinding
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
struct GetPostsListViewModel{
    let userLists : Observable<[MemberCellViewModel]> = Observable(value: [])
    let isLoading : Observable<Bool> = Observable(value: false)
    let isTableViewHidden : Observable<Bool> = Observable(value: false)
    let title : Observable <String> = Observable(value: "Loading")
}
