//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Vlad Panchenko on 26.04.2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGrindButton()
    func didTapTaggedButton()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {

   static let identifier = "ProfileTabsCollectionReusableView"
    
    private weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let grindButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .secondarySystemBackground
        button.setBackgroundImage(UIImage(systemName: "teg"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubview(grindButton)
        addSubview(taggedButton)
        grindButton.addTarget(self, action: #selector(didTapGrindButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height-4
        let grigButtonX = ((width/2) - size)/2
        grindButton.frame = CGRect(x: grigButtonX, y: 2, width: size, height: size)
        taggedButton.frame = CGRect(x: grigButtonX + (width/2), y: 2, width: size, height: size)

    }

    @objc private func didTapGrindButton() {
        delegate?.didTapGrindButton()
    }
    
    @objc private func didTapTaggedButton() {
        delegate?.didTapTaggedButton()
    }
}
