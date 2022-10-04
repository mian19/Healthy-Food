//
//  SectionCollectionView.swift
//  Healthy Food
//
//  Created by Kyzu on 4.10.22.
//

import UIKit

class SectionCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var vcDelegate: ViewController!
    var indexInStack: Int!
    var selectedIndexes: Set<IndexPath> = []
    var cells: [Item]?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        register(UINib(nibName: String(describing: SectionCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: "article")
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems(cells: [Item]?) {
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "article", for: indexPath) as! SectionCollectionViewCell
        cell.updateUI(articleItem: cells?[indexPath.row], indexPath: indexPath.row)
        if selectedIndexes.contains(indexPath) {
            cell.layer.borderWidth = 4
        } else {
            cell.layer.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? SectionCollectionViewCell
        if  !vcDelegate.checkSelectedArticle(indexInStack: indexInStack, selectedIndex: indexPath) {
            selectedIndexes.insert(indexPath)
            selectedCell?.layer.borderWidth = 4
            selectedCell?.layer.borderColor = UIColor(rgb: 0x8e9ff8).cgColor
        } else {
            selectedCell?.layer.borderWidth = 0
            selectedIndexes.remove(indexPath)
        }
    }
    
}
