//
//  ScrollingView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ScrollingView: UIView {
    
    init(cellClass: AnyClass, cellId: String) {
        super.init(frame: .zero)
        self.cellId = cellId
        self.cellClass = cellClass
        setupViews()
        addTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellId = String()
    var cellClass: AnyClass?
    var imgs = [UIImage](){
        didSet{
            collectionView.reloadData()
            setupCurrentIndex(imgsCount: imgs.count)
            pageView.numberOfPages = imgs.count
            addTimer()
        }
    }
    var timer: Timer?
    var oldOffset: CGFloat = 0.0
    var currentIndexPath: IndexPath?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageView: UIPageControl = {
        let pv = UIPageControl()
        pv.currentPage = 0
        pv.pageIndicatorTintColor = .gray
        pv.currentPageIndicatorTintColor = .white
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    
    
    private func setupViews() {
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellId)
        addSubview(collectionView)
        collectionView.fullAnchor(superView: self)
        collectionView.layoutIfNeeded()
        addSubview(pageView)
        pageView.anchor(top: nil, bottom: bottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 100, height: 40)
        pageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    public func setupValue(imgs: [UIImage]){
        self.imgs = imgs
    }
}




extension ScrollingView{
    func setupCurrentIndex(imgsCount: Int){
        currentIndexPath = IndexPath(item: imgsCount, section: 0)
        collectionView.scrollToItem(at: currentIndexPath!, at: .centeredHorizontally, animated: true)
    }
    
    func addTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { [weak self](_) in
            guard let currentIndexPath = self?.currentIndexPath else {return}
            self?.showImage(isNext: true, indexPath: currentIndexPath)
        })
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func showImage(isNext: Bool, indexPath: IndexPath) {
        var index: Int
        if isNext{
            index = indexPath.item + 1
        }else{
            index = indexPath.item - 1
        }
        currentIndexPath = IndexPath(item: index, section: 0)
        showPageViewAndCollectionView(indexPath: currentIndexPath!, imgs: imgs)
    }
    
    func showPageViewAndCollectionView(indexPath: IndexPath, imgs: [UIImage]) {
        pageView.currentPage = indexPath.item % imgs.count
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
    }
    
    func reloadImage(indexPath: IndexPath, imgs: [UIImage]){
        if indexPath.item == imgs.count * 2 - 1{
            currentIndexPath = IndexPath(item: imgs.count - 1, section: 0)
            collectionView.scrollToItem(at: currentIndexPath!, at: .centeredHorizontally, animated: false)
        }else if indexPath.item == 0{
            currentIndexPath = IndexPath(item: imgs.count, section: 0)
            collectionView.scrollToItem(at: currentIndexPath!, at: .centeredHorizontally, animated: false)
        }
    }
}
