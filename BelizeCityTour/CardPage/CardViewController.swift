//
//  CardViewController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/4.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    let slideLeftTransitionAnimator = SlideLeftTransitionAnimator()
    var places = Place.getPlaces()
    lazy var postShown = [Bool](repeating: false, count: places.count)
    lazy var isAnimatedShown = [Bool](repeating: true, count: places.count)

    lazy var backgroundImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "map")?.blurred(radius: 10)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    
    let cardCellId = "cardCellId"
    lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: IconsConstant.back.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return btn
    }()
    
    @objc func popVC(){
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func registerCell(){
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: cardCellId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundRiceColor
        setupBackgroundImgView()
        setupCollectionView()
        registerCell()
        setCollectionViewProperty()
        setupDismissButton()
        collectionView.backgroundColor = .clear
    }
    

}


extension CardViewController{
    fileprivate func setupBackgroundImgView(){
        view.addSubview(backgroundImgView)
        backgroundImgView.fullAnchor(superView: view, topPadding: -30, bottomPadding: -30, leftPadding: -30, rightPadding: -30)
    }
    
    fileprivate func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.anchor(top: nil, bottom: nil, left: view.leftAnchor, right: view.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: UIScreen.main.bounds.height/2)
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setCollectionViewProperty(){
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.backgroundRiceColor
    }
    
    fileprivate func setupDismissButton(){
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 60)
    }
}

extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if postShown[indexPath.row] {
            return
        }
        postShown[indexPath.row] = true
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -600, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut , animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellId, for: indexPath) as! CardCollectionViewCell
        cell.place = places[indexPath.row]
        cell.setCorner(radius: 10.0)
        cell.likedButtonDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController.init(place: places[indexPath.item])
        let naviVC = UINavigationController(rootViewController: detailVC)
        naviVC.transitioningDelegate = slideLeftTransitionAnimator
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true, completion: nil)
    }
}


extension  CardViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 30, height: collectionView.bounds.height - 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    
}


extension CardViewController: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

extension CardViewController: LikeButtonDelegate{
    func didLikedButtonPressed(cell: CardCollectionViewCell, completionHandler: (Bool) -> ()) {
        if let indexPath = collectionView.indexPath(for: cell){
            places[indexPath.row].isLiked = places[indexPath.row].isLiked ? false : true
            cell.isLiked = places[indexPath.row].isLiked
            completionHandler(isAnimatedShown[indexPath.row])
            if isAnimatedShown[indexPath.row]{
                isAnimatedShown[indexPath.row] = false
            }else{
                isAnimatedShown[indexPath.row] = true
            }
        }
    }
}
