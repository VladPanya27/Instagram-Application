//
//  ProfileInfoCollectionReusableView.swift
//  Instagram
//
//  Created by Vlad Panchenko on 26.04.2022.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)

}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {

   static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate:ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let photoProfileImageView:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.masksToBounds = true
        return image
    }()
    
    private let postsButton:UIButton = {
        let posts = UIButton()
        posts.setTitle("Post", for: .normal)
        posts.setTitleColor(.label, for: .normal)
        posts.backgroundColor = .secondarySystemBackground
        return posts
    }()
    
    
    private let followingButton:UIButton = {
        let following = UIButton()
        following.setTitle("Following", for: .normal)
        following.setTitleColor(.label, for: .normal)
        following.backgroundColor = .secondarySystemBackground
        return following
    }()
    
    
    private let followersButton:UIButton = {
        let followers = UIButton()
        followers.setTitle("Followers", for: .normal)
        followers.setTitleColor(.label, for: .normal)
        followers.backgroundColor = .secondarySystemBackground
        return followers
    }()
    
    private let editProfileButton:UIButton = {
        let edit = UIButton()
        edit.setTitle("Edit your profile", for: .normal)
        edit.setTitleColor(.label, for: .normal)
        edit.backgroundColor = .secondarySystemBackground
        return edit
    }()
    
    private let namelabel:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Joe Smith"
        return label
    }()
    
    private let biolabel:UILabel = {
        let bio = UILabel()
        bio.textColor = .label
        bio.numberOfLines = 0
        bio.text = "This is the first account!"
        return bio
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        
        photoProfileImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize).integral
        
        photoProfileImageView.layer.cornerRadius = profilePhotoSize/2.0
        
        let buttonHeight = profilePhotoSize/2
        
        let countBurronWidth = (width - 10 - profilePhotoSize)/3
       
        postsButton.frame = CGRect(
            x: photoProfileImageView.right,
            y: 5,
            width: countBurronWidth,
            height: buttonHeight).integral
        
        followersButton.frame = CGRect(
            x: postsButton.right,
            y: 5,
            width: countBurronWidth,
            height: buttonHeight).integral
    
        followingButton.frame = CGRect(
            x: followersButton.right,
            y: 5,
            width: countBurronWidth,
            height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(
            x: photoProfileImageView.right,
            y: 5 + buttonHeight,
            width: countBurronWidth*3,
            height: buttonHeight).integral
    
        namelabel.frame = CGRect(
            x: 5,
            y: 5 + photoProfileImageView.bottom,
            width: width - 10,
            height: 50).integral
    
        let bioLabelSize = biolabel.sizeThatFits(frame.size)
        biolabel.frame = CGRect(
            x: 5,
            y: 5 + namelabel.bottom,
            width: width - 10,
            height: bioLabelSize.height).integral
    }
    
    private func addSubviews() {
        addSubview(photoProfileImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(namelabel)
        addSubview(biolabel)
    }
    
    @objc private func didTapFollowerButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }

}
