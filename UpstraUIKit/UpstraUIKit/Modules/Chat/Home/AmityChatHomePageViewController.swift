//
//  AmityChatHomePageViewController.swift
//  AmityUIKit
//
//  Created by Sarawoot Khunsri on 6/11/2563 BE.
//  Copyright © 2563 Amity. All rights reserved.
//

import UIKit
import SwiftEventBus
import AmitySDK

/// Amity Chat home
public class AmityChatHomePageViewController: AmityPageViewController {
    
    // MARK: - Properties
    var recentsChatViewController = AmityRecentChatViewController.make()
    
    // MARK: - View lifecycle
    private init() {
        super.init(nibName: AmityChatHomePageViewController.identifier, bundle: AmityUIKitManager.bundle)
        title = AmityLocalizedStringSet.chatTitle.localizedString
        if(AmityRecentChatViewController.isLiveStreamEnabled){
            let searchItem = UIBarButtonItem(image: AmityIconSet.iconChatCreate, style: .plain, target: self, action:  #selector(didClickAdd(_:)))
            searchItem.tintColor = AmityColorSet.base
            navigationItem.rightBarButtonItem = searchItem
        }
    }        
    
    @objc func didClickAdd(_ barButton: UIBarButtonItem) {
        AmityChannelEventHandler.shared.channelCreateNewChat(
            from: self,
            completionHandler: { [weak self] storeUsers in
                guard self != nil else { return }
                self?.recentsChatViewController.screenViewModel.action.createChannel(users: storeUsers)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func make() -> AmityChatHomePageViewController {
        return AmityChatHomePageViewController()
    }
    
    override func viewControllers(for pagerTabStripController: AmityPagerTabViewController) -> [UIViewController] {
        recentsChatViewController.pageTitle = AmityLocalizedStringSet.recentTitle.localizedString
        return [recentsChatViewController]
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        SwiftEventBus.post("onHideBottomNavigationBar",sender: false)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        SwiftEventBus.post("onHideBottomNavigationBar",sender: true)
    }
    
}
