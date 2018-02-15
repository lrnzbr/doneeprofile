//
//  HeaderView.swift
//  doneeprofile
//
//  Created by Lorenzo Brown on 2/12/18.
//  Copyright © 2018 lrnzbr. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var imageView:UIImageView!
    var churchInfoContainer:UIView!
    var favoritesContainer:UIView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.blue
        
        //Setup Image View
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)

        
        //Setup Church Info Container
     /*   churchInfoContainer = UIView()
        churchInfoContainer.backgroundColor = UIColor.green
        churchInfoContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(churchInfoContainer)
        
        //Setup Favorites Container
        favoritesContainer = UIView()
        favoritesContainer.backgroundColor = UIColor.orange
        favoritesContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(favoritesContainer) */
        
        //constraints
        
        let constraints:[NSLayoutConstraint] = [imageView.topAnchor.constraint(equalTo: self.topAnchor), imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor), imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                                imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                                                
//            churchInfoContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor), churchInfoContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor), churchInfoContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//
//          favoritesContainer.topAnchor.constraint(equalTo: churchInfoContainer.bottomAnchor), favoritesContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor), favoritesContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        imageView.image = UIImage(named:"image")
        imageView.contentMode = .scaleAspectFill
    }
    
    
    
    

}
