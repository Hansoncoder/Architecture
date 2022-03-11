//
//  UIVIew+Click.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var clickedKey = "AddClickedEvent"
    }
    
    private var block: (() -> Void?)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.clickedKey) as? (() -> Void?)
        }
        set (manager) {
            addTapGesture()
            objc_setAssociatedObject(self, &AssociatedKeys.clickedKey, manager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addClick<T: AnyObject>(on target: T, block: ((T) -> Void)?) {
        self.block = {[weak target] in
            guard let target = target else {
                return nil
            }
            return block?(target)
        }
    }
    
    private func addTapGesture() {
        if (self.gestureRecognizers == nil) {
            
            self.isUserInteractionEnabled = true
            
            // :添加单击事件
            let tap = UITapGestureRecognizer(target: self, action: #selector(tagAction))
            self.addGestureRecognizer(tap)
        }
    }
    
    @objc func tagAction() {
        block?()
    }
}


