//
//  TagsViewController.swift
//  Pixabay
//
//  Created by Beqa Tabunidze on 07.08.22.
//  Copyright © 2022 Giorgi Tabunidze. All rights reserved.
//

import UIKit

protocol TagSelectionDelegate: AnyObject {
    func tagSelected(was tag: String)
}

class TagsViewController: UIViewController {

    var allTags: [String] = []
    weak var delegate: TagSelectionDelegate?
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    @objc func close() {
        dismiss(animated: true)
    }
    
    private func configCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewHelper.createTagFlowLayout(in: view))
        view.addSubview(collectionView!)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.85)  // Semi-opaque background
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseId)
    }
}

extension TagsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseId, for: indexPath) as! TagCell
        cell.text = allTags[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
        delegate?.tagSelected(was: allTags[indexPath.row])
    }
}
