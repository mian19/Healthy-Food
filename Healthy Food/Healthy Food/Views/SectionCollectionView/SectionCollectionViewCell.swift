//
//  SectionCollectionViewCell.swift
//  Healthy Food
//
//  Created by Kyzu on 4.10.22.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var sectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        clipsToBounds = true
    }

    
    func updateUI(articleItem: Item?) {
        sectionNameLabel.text = articleItem?.title ?? "Loading..."
        
        guard let imageURLString = articleItem?.image.the1X else { return }
        print(imageURLString)
        guard let imageURL = URL(string: imageURLString) else {
            sectionImageView.image = UIImage(named: "noImageAvailable")
            return }
        
        sectionImageView.image = nil
        sectionImageView.contentMode = .top
        
        setImageForArticle(url: imageURL)
    }
    
    //MARK: - work with network
    private func setImageForArticle(url: URL) {
        NetworkManager().getImageForArticle(url: url) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.sectionImageView.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
