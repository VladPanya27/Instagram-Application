//
//  IGFeedPostsActionCell.swift
//  Instagram
//
//  Created by Vlad Panchenko on 23.04.2022.
//

import UIKit

class IGFeedPostsActionCell: UITableViewCell {

    static let identifier = "IGFeedPostsActionCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
    }
}
