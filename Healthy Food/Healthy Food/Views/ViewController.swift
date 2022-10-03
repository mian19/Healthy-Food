//
//  ViewController.swift
//  Healthy Food
//
//  Created by Kyzu on 3.10.22.
//

import UIKit

class ViewController: UIViewController {

    private var jsonResponse: JSONResponse? = JSONManager().fetchingInformation()
    private var categoryCollectionView: SectionCollectionView!
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
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
        categoryCollectionView = SectionCollectionView()
        stackView.addArrangedSubview(categoryCollectionView)
    }
    
    private func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 300),
                view.heightAnchor.constraint(equalToConstant: 300)
            ])
        }
    }
    
//
  
}

