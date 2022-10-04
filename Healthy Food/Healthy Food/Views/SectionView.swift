//
//  SectionView.swift
//  Healthy Food
//
//  Created by Kyzu on 4.10.22.
//

import UIKit

class SectionView: UIView {

    var sectionName: UILabel!
    var sectionArticlesCollection: SectionCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        setSectionName()
        setArticlesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSectionName() {
        sectionName = UILabel()
        sectionName.translatesAutoresizingMaskIntoConstraints = false
        sectionName.font = UIFont.boldSystemFont(ofSize: 25.0)
        sectionName.textAlignment = .left
        sectionName.textColor = UIColor.init(rgb: 0x2d3351)
        
        addSubview(sectionName)
        
        sectionName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sectionName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        sectionName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setArticlesCollectionView() {
        sectionArticlesCollection = SectionCollectionView()
        addSubview(sectionArticlesCollection)
        
        sectionArticlesCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 15).isActive = true
        sectionArticlesCollection.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sectionArticlesCollection.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sectionArticlesCollection.heightAnchor.constraint(equalToConstant: 225).isActive = true
    }

}
