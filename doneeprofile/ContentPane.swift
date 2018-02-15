//
//  ContentPane.swift
//  doneeprofile
//
//  Created by Lorenzo Brown on 2/13/18.
//  Copyright © 2018 lrnzbr. All rights reserved.
//

import UIKit

protocol ContentPaneDelegate: class {
    func repositionHorizontalBar(offset:CGFloat)
    func highlightMenuItem(position:NSIndexPath)
}

class ContentPane: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    weak var delegate:ContentPaneDelegate?
    let cellId = "cellId"
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.green
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.blue
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let color:[UIColor] = [.red, .orange, .green, .purple]
        cell.backgroundColor = color[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        let offset = scrollView.contentOffset.x / 4
        delegate?.repositionHorizontalBar(offset:offset)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        delegate?.highlightMenuItem(position: indexPath)
    }
    
    
}



