//
//  test.swift
//  Architecture
//
//  Created by Hanson on 2022/3/13.
//

import Foundation
//lazy var testView = UIView()
//view.addSubview(testView)
//testView.frame = CGRect(
//    x: 10, y: 10,
//    width: 100, height: 100
//)

//
//let dispatchSemaphore = DispatchSemaphore(value: 0)
//
//
//private func totalCount() {
//    // 1. 创建Observer
//    guard let runloopObserver = buildRunLoopObserver() else {
//        return
//    }
//    // 2. 给主线程设置Observer
//    CFRunLoopAddObserver(CFRunLoopGetMain(), runloopObserver, CFRunLoopMode.commonModes)
//
//    let begin = Date().timeIntervalSince1970
//    DispatchQueue.global().async { [weak self] in
//        while true {
//            dispatchSemaphore.wait()
//            DispatchQueue.main.sync {
//                let isShow = self?.testView.isDisplayedInScreen
//                if isShow == nil || isShow == false {
//                    let end = Date().timeIntervalSince1970
//                    print("\(end-begin)")
//                }
//            }
//        }
//    }
//}
//
//private func buildRunLoopObserver() -> CFRunLoopObserver? {
//    var context = CFRunLoopObserverContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
//    let observer = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, runLoopObserverCallback(), &context)
//    return observer
//}
//
//func runLoopObserverCallback() -> CFRunLoopObserverCallBack {
//    return { observer, activity, info in
//        if activity == .beforeWaiting {
//            dispatchSemaphore.signal()
//        }
//    }
//}
