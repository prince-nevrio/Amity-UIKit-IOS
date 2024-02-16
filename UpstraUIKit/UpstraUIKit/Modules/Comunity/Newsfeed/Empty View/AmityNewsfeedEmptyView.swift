//
//  AmityNewsfeedEmptyView.swift
//  AmityUIKit
//
//  Created by Sarawoot Khunsri on 24/8/2563 BE.
//  Copyright © 2563 Amity. All rights reserved.
//

import UIKit

final class AmityNewsfeedEmptyView: AmityView {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var exploreCommunityButton: AmityButton!
    @IBOutlet private var createCommunityButton: AmityButton!
    
    // MARK: - Properties
    var exploreHandler: (() -> Void)?
    var createHandler: (() -> Void)?
    
    override func initial() {
        loadNibContent()
        setupView()
    }
    
    private func setupView() {
        backgroundColor = AmityColorSet.backgroundColor
        contentView.backgroundColor = AmityColorSet.backgroundColor
        
        imageView.image = AmityIconSet.emptyNewsfeed
        titleLabel.text = AmityLocalizedStringSet.emptyNewsfeedTitle.localizedString
        titleLabel.textColor = AmityColorSet.primary
        titleLabel.font = AmityTypography.defaultFont(ofSize: 34, weight: .bold,fontName: "Recoleta-Medium")
        
        subtitleLabel.text = AmityLocalizedStringSet.emptyNewsfeedSubtitle.localizedString
        
        exploreCommunityButton.setTitle(AmityLocalizedStringSet.emptyNewsfeedExploreButton.localizedString, for: .normal)
        exploreCommunityButton.setTitleFont(AmityFontSet.title)
        exploreCommunityButton.setTitleColor(AmityColorSet.primary, for: .normal)
        exploreCommunityButton.backgroundColor = AmityColorSet.secondary
        exploreCommunityButton.tintColor = AmityColorSet.baseInverse
       // exploreCommunityButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        exploreCommunityButton.layer.cornerRadius = exploreCommunityButton.layer.frame.height/2
        
        createCommunityButton.setTitle(AmityLocalizedStringSet.emptyNewsfeedCreateButton.localizedString, for: .normal)
        createCommunityButton.setTitleFont(AmityFontSet.title)
        createCommunityButton.setTitleColor(AmityColorSet.primary, for: .normal)
        createCommunityButton.setTitleColor(AmityColorSet.primary.blend(.shade2), for: .disabled)
        createCommunityButton.isEnabled = Reachability.shared.isConnectedToNetwork
        
        if(AmityRecentChatViewController.isLiveStreamEnabled){
            createCommunityButton.isHidden = false
        }else{
            createCommunityButton.isHidden = true
        }
    }
    
    func setNeedsUpdateState() {
        createCommunityButton.isEnabled = Reachability.shared.isConnectedToNetwork
    }
    
}

// MARK: - Action
private extension AmityNewsfeedEmptyView {
    @IBAction func exploreCommunityTap() {
        exploreHandler?()
    }
    
    @IBAction func createCommunityTap() {
        createHandler?()
    }
}
