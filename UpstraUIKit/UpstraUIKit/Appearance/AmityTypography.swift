//
//  AmityTypography.swift
//  AmityUIKit
//
//  Created by Sarawoot Khunsri on 10/6/2563 BE.
//  Copyright © 2563 Amity Communication. All rights reserved.
//

import UIKit

// Note
// See more:
// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
// https://uxdesign.cc/a-five-minute-guide-to-better-typography-for-ios-4e3c2715ceb4
// https://docs.sendbird.com/ios/ui_kit_themes#3_fontset_4_customize_font

public struct AmityTypography {
    
    let headerLine: UIFont
    let title: UIFont
    let titleLarge: UIFont
    let bodyBold: UIFont
    let body: UIFont
    let bodyRecoleta: UIFont
    let captionBold: UIFont
    let caption: UIFont
    let captionRecoleta: UIFont
    
    public init(headerLine: UIFont? = nil,
                title: UIFont? = nil,
                titleLarge: UIFont? = nil,
                bodyBold: UIFont? = nil,
                body: UIFont? = nil,
                bodyRecoleta: UIFont? = nil,
                captionBold: UIFont? = nil,
                caption: UIFont? = nil,
                captionRecoleta: UIFont? = nil) {
        self.headerLine = headerLine ?? AmityTypography.defaultFont(ofSize: 20, weight: .bold,fontName: "Recoleta-Medium")
        self.title = title ?? AmityTypography.defaultFont(ofSize: 17, weight: .semibold,fontName: "Recoleta-Medium")
        self.titleLarge = title ?? AmityTypography.defaultFont(ofSize: 21, weight: .semibold,fontName: "Recoleta-Medium")
        self.bodyBold = bodyBold ?? AmityTypography.defaultFont(ofSize: 15, weight: .semibold,fontName: "Inter-Regular")
        self.body = body ?? AmityTypography.defaultFont(ofSize: 15, weight: .regular,fontName: "Inter-Regular")
        self.bodyRecoleta = bodyRecoleta ?? AmityTypography.defaultFont(ofSize: 15, weight: .regular,fontName: "Recoleta-Medium")
        self.captionBold = captionBold ?? AmityTypography.defaultFont(ofSize: 13, weight: .semibold,fontName: "Inter-Regular")
        self.caption = caption ?? AmityTypography.defaultFont(ofSize: 13, weight: .regular,fontName: "Inter-Regular")
        self.captionRecoleta = caption ?? AmityTypography.defaultFont(ofSize: 13, weight: .regular,fontName: "Recoleta-Regular")
    }
    
     static func defaultFont(ofSize size: CGFloat, weight: UIFont.Weight, fontName : String) -> UIFont {
           if let customFont = UIFont(name: fontName, size: size) {
               return customFont
           } else {
               return UIFont.systemFont(ofSize: size, weight: weight)
           }
       }
}

public class AmityFontSet {
    
    static private(set) var currentTypography: AmityTypography = AmityTypography()
    
    static func set(typography: AmityTypography) {
        currentTypography = typography
    }
    
    public static var headerLine: UIFont {
        return currentTypography.headerLine
    }
    
    public static var title: UIFont {
        return currentTypography.title
    }
    
    public static var titleLarge: UIFont {
        return currentTypography.titleLarge
    }
    
    public static var bodyBold: UIFont {
        return currentTypography.bodyBold
    }
    
    public static var body: UIFont {
        return currentTypography.body
    }
    
    public static var bodyRecoleta: UIFont {
        return currentTypography.bodyRecoleta
    }
    
    public static var captionBold: UIFont {
        return currentTypography.captionBold
    }
    
    public static var caption: UIFont {
        return currentTypography.caption
    }
    
    public static var captionRecoleta: UIFont {
        return currentTypography.captionRecoleta
    }
    
}
