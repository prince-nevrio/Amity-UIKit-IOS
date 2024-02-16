//
//  AmityKeyboardService.swift
//  AmityUIKit
//
//  Created by Sarawoot Khunsri on 30/7/2563 BE.
//  Copyright © 2563 Amity Communication. All rights reserved.
//

import UIKit

protocol AmityKeyboardServiceDelegate: AnyObject {
    func keyboardWillAppear(service: AmityKeyboardService)
    func keyboardWillDismiss(service: AmityKeyboardService)
    func keyboardWillChange(service: AmityKeyboardService,
                            height: CGFloat,
                            animationDuration: TimeInterval)
}

extension AmityKeyboardServiceDelegate {
    func keyboardWillAppear(service: AmityKeyboardService) {}
    func keyboardWillDismiss(service: AmityKeyboardService) {}
    func keyboardWillChange(service: AmityKeyboardService,
                            newHeight: CGFloat,
                            oldHeight: CGFloat,
                            animationDuration: TimeInterval) {}
}

final class AmityKeyboardService: NSObject {
    static var shared: AmityKeyboardService = AmityKeyboardService()

    private var isKeyboardVisible = false

    private override init() {
        super.init()
        subscribeToKeyboardEvents()
    }

    weak var delegate: AmityKeyboardServiceDelegate?

    func subscribeToKeyboardEvents() {
        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)

        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }

    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        guard !isKeyboardVisible else {
            // If the keyboard is already visible, do not trigger another event
            return
        }

        isKeyboardVisible = true

        delegate?.keyboardWillAppear(service: self)

        if
            let userInfo: [AnyHashable: Any] = notification.userInfo,
            let durationAny: Any = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey],
            let duration: TimeInterval = durationAny as? TimeInterval,
            let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardSize.size.height
            delegate?.keyboardWillChange(service: self,
                                         height: keyboardHeight,
                                         animationDuration: duration)
        }
    }

    @objc
    private func keyboardWillHide(_ notification: NSNotification) {
        guard isKeyboardVisible else {
            // If the keyboard is already hidden, do not trigger another event
            return
        }

        isKeyboardVisible = false

        delegate?.keyboardWillDismiss(service: self)

        let duration: TimeInterval
        if
            let userInfo: [AnyHashable: Any] = notification.userInfo,
            let durationAny: Any = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey],
            let timeInterval: TimeInterval = durationAny as? TimeInterval {
            duration = timeInterval
        } else {
            duration = 0
        }
        delegate?.keyboardWillChange(service: self,
                                     height: 0,
                                     animationDuration: duration)
    }

    func dismissKeyboard() {
        // Dismiss the keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
