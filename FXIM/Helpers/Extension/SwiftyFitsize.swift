//
//  SwiftyFitsize.swift
//  FXGeneralSwift
//
//  Created by fuxinto on 2019/11/5.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import UIKit

/*字体适配(UI设计图上面的尺寸)
 px:相对长度单位。像素（Pixel）。（PS字体）
 pt:绝对长度单位。点（Point）。（iOS字体）
 UI标记图上给我们字体的大小一般都是像素点，px = 2*pt
 */
 let referenceW : CGFloat = 375.0


fileprivate let ScreenW = UIScreen.main.bounds.width

// MARK: operator ~
postfix operator ~
public postfix func ~ (value: CGFloat) -> CGFloat {
    return ScreenW/referenceW*value
}
public postfix func ~ (font: UIFont) -> UIFont {
    return font.withSize(font.pointSize~)
}
public postfix func ~ (value: Int) -> CGFloat {
    return CGFloat(value)~
}
public postfix func ~ (value: Float) -> CGFloat {
    return CGFloat(value)~
}
public postfix func ~ (value: CGPoint) -> CGPoint {
    return CGPoint(
        x: value.x~,
        y: value.y~
    )
}
public postfix func ~ (value: CGSize) -> CGSize {
    return CGSize(
        width: value.width~,
        height: value.height~
    )
}
public postfix func ~ (value: CGRect) -> CGRect {
    return CGRect(
        x: value.origin.x~,
        y: value.origin.y~,
        width: value.size.width~,
        height: value.size.height~
    )
}
public postfix func ~ (value: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(
        top: value.top~,
        left: value.left~,
        bottom: value.bottom~,
        right: value.right~
    )
}


// MARK:- Xib/Storyboard
public extension NSLayoutConstraint {
    @IBInspectable var swiftyFit: Bool {
        get { return false }
        set {
            constant =  constant~
        }
    }
}
public extension UILabel {
    @IBInspectable var fontFit: Bool {
        get { return false }
        set {
            guard let xfont = font else { return }
            self.font = xfont~
        }
    }
}

public extension UITextView {
    @IBInspectable var fontFit: Bool {
       get { return false }
        set {
            guard let xfont = font else { return }
            self.font = xfont~
        }
    }
}
public extension UITextField {
    @IBInspectable var fontFit: Bool {
       get { return false }
        set {
            guard let xfont = font else { return }
            self.font = xfont~
        }
    }
}
public extension UIButton {
    @IBInspectable var fontFit: Bool {
       get { return false }
        set {
            guard let xfont = titleLabel?.font else { return }
            self.titleLabel?.font = xfont~
        }
    }
}



