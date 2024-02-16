//
//  AmityCommunityHomePageViewController.swift
//  AmityUIKit
//
//  Created by Nontapat Siengsanor on 18/8/2563 BE.
//  Copyright © 2563 Amity. All rights reserved.
//

import UIKit
import SwiftEventBus

public class AmityCommunityHomePageViewController: AmityPageViewController {
    
    // MARK: - Properties
    public let newsFeedVC = AmityNewsfeedViewController.make()
    public let exploreVC = AmityCommunityExplorerViewController.make()
    
    private init() {
        super.init(nibName: AmityCommunityHomePageViewController.identifier, bundle: AmityUIKitManager.bundle)
        title = AmityLocalizedStringSet.communityHomeTitle.localizedString
    }
    
    public override func viewWillAppear(_ animated: Bool) {
            SwiftEventBus.post("onHideBottomNavigationBar",sender: false)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        SwiftEventBus.post("onHideBottomNavigationBar",sender: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    public static func make() -> AmityCommunityHomePageViewController {
        let controller = AmityCommunityHomePageViewController()
        return controller
    }
    
    override func viewControllers(for pagerTabStripController: AmityPagerTabViewController) -> [UIViewController] {
        newsFeedVC.pageTitle = AmityLocalizedStringSet.newsfeedTitle.localizedString
        exploreVC.pageTitle = AmityLocalizedStringSet.exploreTitle.localizedString
        return [newsFeedVC, exploreVC]
    }
    
    // MARK: - Setup view
    
    private func setupNavigationBar() {
        let searchItem = UIBarButtonItem(image: AmityIconSet.iconSearch, style: .plain, target: self, action: #selector(searchTap))
        searchItem.tintColor = AmityColorSet.base
        navigationItem.rightBarButtonItem = searchItem
       
        SwiftEventBus.onMainThread(self, name: "firstTab") { result in
            self.setCurrentIndex(0,animated: true)
        }
        SwiftEventBus.onMainThread(self, name: "secondTab") { result in
            self.setCurrentIndex(1,animated: true)
        }
    }
}

// MARK: - Action
private extension AmityCommunityHomePageViewController {
    @objc func searchTap() {
        let searchVC = AmitySearchViewController.make()
        let nav = UINavigationController(rootViewController: searchVC)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
}

