//
//  IGFeedPostHeaderCell.swift
//  Instagram
//
//  Created by Vlad Panchenko on 23.04.2022.
//

import UIKit

class IGFeedPostHeaderCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure() {
    }
}
