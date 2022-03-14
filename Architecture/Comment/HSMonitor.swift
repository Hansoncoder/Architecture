//
//  HSMonitor.swift
//  Architecture
//
//  Created by Hanson on 2022/3/13.
//

import Foundation
class HSMonitor {
    static let shared = HSMonitor()
    
    var isMoniting = false
    var timeoutCount = 0
    var runLoopActivity = CFRunLoopActivity.entry
    var dispatchSemaphore = DispatchSemaphore(value: 0)
    
    var runloopObserver: CFRunLoopObserver?
    
    func start() {
        guard !isMoniting else { return }
        
        self.runloopObserver = buildRunLoopObserver()
        if self.runloopObserver == nil {
            print("创建监听失败...")
            return
        }
        
        isMoniting = true
        CFRunLoopAddObserver(CFRunLoopGetMain(), runloopObserver, CFRunLoopMode.commonModes)
        
        DispatchQueue.global().async {
            while true {
                let wait = self.dispatchSemaphore.wait(timeout: DispatchTime.now() + 0.05)
                if DispatchTimeoutResult.timedOut == wait {
                    guard self.runloopObserver != nil else {
                        self.runLoopActivity = .entry
                        return
                    }
                    
                    if self.runLoopActivity == .beforeSources || self.runLoopActivity == .afterWaiting {
                        if self.timeoutCount < 5 {
                            self.timeoutCount += 1
                            continue
                        }
                        
                        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                            print("check the cpu info...")
                        }
                    }
                }
                
                self.timeoutCount = 0
            }
        }
        
    }
    
    func end() {
        guard self.runloopObserver != nil else {
            return
        }
        self.isMoniting = false
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), self.runloopObserver, CFRunLoopMode.commonModes)
        self.runloopObserver = nil
    }
    
    private func buildRunLoopObserver() -> CFRunLoopObserver? {
        let info = Unmanaged<HSMonitor>.passUnretained(self).toOpaque()
        var context = CFRunLoopObserverContext(version: 0, info: info, retain: nil, release: nil, copyDescription: nil)
        let observer = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, runLoopObserverCallback(), &context)
        return observer
    }
    
    
    func runLoopObserverCallback() -> CFRunLoopObserverCallBack {
        return { observer, activity, info in
            guard let info = info else {
                return
            }
            
            let weakSelf = Unmanaged<HSMonitor>.fromOpaque(info).takeUnretainedValue()
            weakSelf.runLoopActivity = activity
            weakSelf.dispatchSemaphore.signal()
        }
    }
}
