//
//  EkoFeedDelegate.swift
//  UpstraUIKit
//
//  Created by sarawoot khunsri on 2/15/21.
//  Copyright © 2021 Upstra. All rights reserved.
//

import UIKit

/// This protocol for providing to custom action of header/footer
public protocol EkoFeedDelegate: class {
    func didPerformActionLikePost()
    func didPerformActionUnLikePost()
    func didPerformActionLikeComment()
    func didPerformActionUnLikeComment()
}
