//
//  ViewController.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var titleLabelOutlet: UILabel!
    
    
    @IBOutlet weak var lblCount: UILabel!
    
    var viewModel : GetPostsListViewModel{
        return controller.viewModel
    }
    lazy var controller : CVListViewController = {
        return CVListViewController()
    }()
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AF.request("http://stagetao.gcf.education:3000/api/v1/postLikes/73/3/false", method: .put, parameters: nil, headers: nil).responseDecodable(of:UpdateLikes.self) { res in
//            print(res)
//        }
        initView()
        initBinding()
        
    }
   
    func initView(){
        
        view.backgroundColor = .white
    }
    func initBinding(){
        
        viewModel.userLists.addObserver { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.isLoading.addObserver { isLoading in
            if isLoading == true {
                self.loadingIndicator.startAnimating()

            }
            else{
                self.loadingIndicator.stopAnimating()
            }
        }
        viewModel.isTableViewHidden.addObserver { isHidden in
            self.collectionView.isHidden = isHidden
        }
        viewModel.title.addObserver { title in
            self.titleLabelOutlet.text = title
        }
        controller.start()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userLists.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .lightGray
        cell.likeIconButton.tag = indexPath.row
//        cell.userNameLabel.text = viewModel.userLists.value[indexPath.row].userName
//        cell.postDataLabelOutlet.text = viewModel.userLists.value[indexPath.row].postData
//        cell.likeIconButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
//        cell.likesCountLabelOutlet.text = "\(viewModel.userLists.value[indexPath.row].totalLikes)"
        
        let rowViewModel = viewModel.userLists.value[indexPath.row]
        if let cell = cell as? CellConfigurable{
            cell.setUp(viewModel: rowViewModel)
        }
        
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10)/2
        return CGSize(width: size, height: size)
        
    }
   
    
}

