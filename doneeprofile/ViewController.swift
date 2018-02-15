//
//  ViewController.swift
//  doneeprofile
//
//  Created by Lorenzo Brown on 2/12/18.
//  Copyright © 2018 lrnzbr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ContentPaneDelegate {
    func repositionHorizontalBar(offset: CGFloat) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = offset
    }
    
    var tableView:UITableView!
    var headerView:HeaderView!
    var headerHeightConstraint:NSLayoutConstraint!
    var backButton:UIButton!
    var giveButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpHeader()
        setUpTableView()
        setupGiveButton()
        setupBackButton()

    }
    
    func setupGiveButton(){
        giveButton = UIButton(frame: CGRect.zero)
        giveButton.setImage(UIImage(named:"btn-full-no-shadow"), for: .normal)
       
        view.addSubview(giveButton)
        view.addConstraintsWithFormat(format: "V:[v0(80)]-30-|", views: giveButton)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: giveButton)
        
    }
    
    func setupBackButton(){
        backButton = UIButton(frame:CGRect.zero)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(backButton)
        view.addConstraintsWithFormat(format: "V:|-10-[v0]", views: backButton)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]", views: backButton)
    }
    
    private func setUpHeader() {
        headerView = HeaderView(frame:CGRect.zero)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)
        
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 350)
        headerHeightConstraint.isActive = true
        
        
        let constraints:[NSLayoutConstraint] = [headerView.topAnchor.constraint(equalTo: view.topAnchor), headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor), headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
   
    
    func setUpTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let constraints:[NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "cell")
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self
   
}
    func animateHeader() {
        self.headerHeightConstraint.constant = 350
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
        self.view.layoutIfNeeded()
        }, completion: nil)
    }
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    let contentPane:ContentPane = {
        let cp = ContentPane()
        cp.translatesAutoresizingMaskIntoConstraints = false
        return cp
    }()
    

    
   private func setupMenuBar() {
    view.addSubview(menuBar)
    view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
    view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    
    }
    
    
}

extension ViewController:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",   for: indexPath as IndexPath)
        cell.addSubview(menuBar)
        cell.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        cell.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        menuBar.viewController = self
        
        cell.addSubview(contentPane)
        contentPane.delegate = self
        cell.addConstraintsWithFormat(format: "H:|[v0]|", views: contentPane)
        cell.addConstraintsWithFormat(format: "V:[v0][v1]|", views: menuBar, contentPane)
        return cell
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        contentPane.collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
}

extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 65 {
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y/100
            if self.headerHeightConstraint.constant < 65 {
                self.headerHeightConstraint.constant = 65
            }
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > 350 {
            animateHeader()
       }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > 350 {
            animateHeader()
           
        }
    }
    func highlightMenuItem(position: NSIndexPath) {
        menuBar.collectionView.selectItem(at: position as IndexPath, animated: true, scrollPosition: [])
    }
}


extension ViewController:UITableViewDelegate {
    
}

extension UIView {
    func addConstraintsWithFormat(format:String, views:UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

