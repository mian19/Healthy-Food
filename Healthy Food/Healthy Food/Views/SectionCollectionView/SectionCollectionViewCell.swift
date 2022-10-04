//
//  SectionCollectionViewCell.swift
//  Healthy Food
//
//  Created by Kyzu on 4.10.22.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
    let backColorsForArticles = [UIColor(rgb: 0xe4f5f6, a: 0.5), UIColor(rgb: 0xd1efff, a: 0.5), UIColor(rgb: 0x98cee6, a: 0.5), UIColor(rgb: 0xced7f6, a: 0.5)]
    @IBOutlet weak var sectionImageView: UIImageView!
    @IBOutlet weak var sectionNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        clipsToBounds = true
        sectionNameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func updateUI(articleItem: Item?, indexPath: Int) {
        backgroundColor = backColorsForArticles[indexPath % backColorsForArticles.count]
        sectionNameLabel.text = articleItem?.title ?? "Loading..."
        
        guard let imageURLString = articleItem?.image.the1X else { return }
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
