//
//  ScrollingView+UICollectionViewDelegate.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

extension ScrollingView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BannerCell
        cell[imgs[indexPath.item % imgs.count]]
        return cell
    }
}


extension ScrollingView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}


extension ScrollingView: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
        oldOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let currentIndexPath = currentIndexPath else {return}
        reloadImage(indexPath: currentIndexPath, imgs: imgs)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //若取消addTimer，代表使用者滑動後，就不再有輪播功能
        //        addTimer()
        guard let currentIndexPath = currentIndexPath else {return}
        if scrollView.contentOffset.x < oldOffset{
            showImage(isNext: false, indexPath: currentIndexPath)
        }else{
            showImage(isNext: true, indexPath: currentIndexPath)
        }
    }
}
