//
//  CollectionViewCell.swift
//  UpdateLikesApiDataBinding
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell ,CellConfigurable{
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postDataLabelOutlet: UILabel!
    @IBOutlet weak var likeIconButton: UIButton!
    @IBOutlet weak var likesCountLabelOutlet: UILabel!
    
    var viewModel : MemberCellViewModel?
    func setUp(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? MemberCellViewModel else{
            return
        }
        self.viewModel = viewModel
        userNameLabel.text = viewModel.userName
        postDataLabelOutlet.text = viewModel.postData
        if(viewModel.likeStatus == true){
            likeIconButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        }
        else{
            likeIconButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        }
        likesCountLabelOutlet.text = "\(viewModel.totalLikes)"
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        viewModel?.likesButtonPressed?()
    }
    
}
