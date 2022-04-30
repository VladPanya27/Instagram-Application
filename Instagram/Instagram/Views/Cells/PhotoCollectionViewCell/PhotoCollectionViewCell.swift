//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Vlad Panchenko on 26.04.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImage:UIImageView = {
       let photo = UIImageView()
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        photoImage.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImage.image = nil
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImage)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: UserPost) {
        let url = model.thumbnailImage
        photoImage.kf.setImage(with: url)
    }
    
    public func configure(debug imageName: String) {
        photoImage.image = UIImage(named: imageName)
    }
    
}
