//
//  NetworkLayer.swift
//  UpdateLikesApiDataBinding
//
//  Created by Naga Divya Bobbara on 21/08/22.
//

import Foundation
import Alamofire
class NetworkLayer{
    func apiCall(completion:@escaping([GetPostsData]?)->Void)
    {
        DispatchQueue.global().async {
            sleep(1)
            AF.request("http://stagetao.gcf.education:3000/api/v1/posts/3", method: .get, parameters: nil,headers: nil).responseDecodable(of: GetPosts.self) { response in
//                self.convertDataObjectToViewModel(response: response.value?.data ?? [])
                completion(response.value?.data)
                
               
            }
        
            
        }
    }
    func updateLikes(postId : Int,likeStatus :Bool,completion:@escaping(Bool)->Void){
            
            AF.request("http://stagetao.gcf.education:3000/api/v1/postLikes/\(postId)/3/\(!(likeStatus))", method: .put, parameters: nil, headers: nil).responseDecodable(of:UpdateLikes.self) { res in
                print(res)
                
                completion(true)
            }
        }
}
