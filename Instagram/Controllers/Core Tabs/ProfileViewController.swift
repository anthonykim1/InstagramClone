//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Anthony Kim on 8/26/20.
//  Copyright © 2020 Anthony Kim. All rights reserved.
//

import UIKit

/// Profile view controller
class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView? // reason why optional: we arae going to instantiate with flow layout

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationbar()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.width/3, height: view.width/3)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else{
            return
        }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureNavigationbar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                        style: .done,
                                                        target: self,
                                                        action: #selector(didTapSettingsButton))
    }
    
    @objc private func didTapSettingsButton() { // so it can be referenced
        let vc = SettingsViewController() // create view controller called SettingsViewController
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
