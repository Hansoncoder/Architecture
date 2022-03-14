//
//  UIView+display.swift
//  Architecture
//
//  Created by Hanson on 2022/3/13.
//

import Foundation
import UIKit

extension UIView {
    public var isDisplayedInScreen: Bool {
        // 未添加到superview
        if superview == nil ||
            window == nil {
            return false
        }
        
        // view 已经隐藏
        if isHidden { return false }
        
        // 转换view对应window的Rect
        var rect = convert(frame, to: nil)
        
        //如果可以滚动，清除偏移量
        if let temp = self as? UIScrollView {
            rect.origin.x += temp.contentOffset.x
            rect.origin.y += temp.contentOffset.y
        }
        
        // 若size为CGrectZero
        if rect.isNull ||
            rect.isEmpty ||
            rect.size == .zero {
            return false
        }
        
        let result = rect.intersection(UIScreen.main.bounds)
        
        return !result.isEmpty && !result.isNull
    }
}
