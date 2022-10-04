//
//  ViewController.swift
//  Healthy Food
//
//  Created by Kyzu on 3.10.22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    private let sectionHeight: CGFloat = 280
    private var jsonResponse: JSONResponse? = JSONManager().fetchingInformation()
    var selectedArticles = Set<Dictionary<Int, Int>>()
    private var contentSize: CGSize {
        guard let jsonResponse = jsonResponse else { return .zero}
        let height: CGFloat = CGFloat(jsonResponse.sections.count) * sectionHeight + CGFloat((jsonResponse.sections.count - 1) * 10)
        return CGSize(width: view.frame.width, height: height)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(rgb: 0xf4f6f7)
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    override func loadView() {
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCategoryCollection()
        setConstraints()
    }
    
    private func setView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setCategoryCollection() {
        for index in 0..<(jsonResponse?.sections.count ?? 0) {
            let sectionView = SectionView()
            sectionView.sectionArticlesCollection.indexInStack = index
            sectionView.sectionName.text = jsonResponse?.sections[index].header
            fillArticles(section: sectionView, index: index)
            
            stackView.addArrangedSubview(sectionView)
        }
    }
    
    private func fillArticles(section: SectionView, index: Int) {
        section.sectionArticlesCollection.vcDelegate = self
        section.sectionArticlesCollection.cells = jsonResponse?.sections[index].items
    }
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10)
        ])
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: stackView.widthAnchor),
                view.heightAnchor.constraint(equalToConstant: sectionHeight)
            ])
        }
    }
    
    func checkSelectedArticle(indexInStack: Int, selectedIndex: IndexPath) -> Bool {
        var returnedBool = true
        let checkedArticle = [indexInStack: selectedIndex.row]
        if selectedArticles.count <= 6 {
            if selectedArticles.contains(checkedArticle) {
                selectedArticles.remove(checkedArticle)
            } else if selectedArticles.count < 6 {
                selectedArticles.insert(checkedArticle)
                returnedBool = false
            }
        }
        return returnedBool
    }
    
    
}

