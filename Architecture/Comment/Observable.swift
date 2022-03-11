//
//  Observable.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import Foundation
import UIKit

class Observable<T>: NSObject {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    private var valueChanged: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func subscrib(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
        valueChanged = onChange
        if fireNow {
            onChange?(value)
        }
    }
    
    func removeObserver() {
        valueChanged = nil
    }
}

extension UIView {
    public var rx: Self {
        return self
    }
    
    func tap() -> Observable<Void> {
        let input = Observable<Void>(value: ())
        addClick(on: self) { (self) in
            input.value = ()
        }
        return input
    }
}
